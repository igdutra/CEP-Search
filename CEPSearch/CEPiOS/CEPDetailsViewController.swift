//
//  CEPDetailsViewController.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import UIKit
import CEPSearch

public struct InfoStrings: Equatable {
    public let title: String
    public let info: String
    
    public init(title: String, info: String) {
        self.title = title
        self.info = info
    }
}

public struct CEPDetailsViewData: Equatable {
    public let cepText: String
    public let addressTexts: InfoStrings
    public let districtTexts: InfoStrings
    public let cityStateTexts: InfoStrings
    
    public init(cepText: String, addressTexts: InfoStrings, districtTexts: InfoStrings, cityStateTexts: InfoStrings) {
        self.cepText = cepText
        self.addressTexts = addressTexts
        self.districtTexts = districtTexts
        self.cityStateTexts = cityStateTexts
    }
}

final class CEPDetailsViewModel {
    private let model: CEPDetails
    
    init(model: CEPDetails) {
        self.model = model
    }
    
    
}

public final class CEPDetailsViewController: UIViewController {
    private let viewData: CEPDetailsViewData
    
    private(set) public lazy var cepTitleLabel: UILabel = createTitleLabel()
    private(set) public lazy var addressView: CepInfoView = {
        CepInfoView(title: viewData.addressTexts.title, info: viewData.addressTexts.info)
    }()
    private(set) public lazy var districtView: CepInfoView = {
        CepInfoView(title: viewData.districtTexts.title, info: viewData.districtTexts.info)
    }()
    private(set) public lazy var cityStateView: CepInfoView = {
        CepInfoView(title:  viewData.cityStateTexts.title, info: viewData.cityStateTexts.info)
    }()
    
    public init(viewData: CEPDetailsViewData) {
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayDetails()
        configureNavigationBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(cepTitleLabel)
        
        let stackView = UIStackView(arrangedSubviews: [addressView, districtView, cityStateView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            cepTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cepTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cepTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cepTitleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func displayDetails() {
        cepTitleLabel.text = viewData.cepText
    }
    
    private func configureNavigationBar() {
        title = viewData.cepText
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withSymbolicTraits(.traitBold)
            ?? UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        let boldLargeTitleFont = UIFont(descriptor: fontDescriptor, size: 0)
        label.font = boldLargeTitleFont
        label.textAlignment = .center
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}


// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    CEPDetailsViewController(viewData:
       CEPDetailsViewData(cepText: "CEP",
                          addressTexts: InfoStrings(title: "Address", info: "Example Street, Apt 101"),
                          districtTexts: InfoStrings(title: "District", info: "Example District"),
                          cityStateTexts: InfoStrings(title: "City", info: "Example City, EX"))
    )
}
