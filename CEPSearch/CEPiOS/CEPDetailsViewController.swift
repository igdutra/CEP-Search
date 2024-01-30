//
//  CEPDetailsViewController.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import UIKit
import CEPSearch

public struct CEPDetailsViewData: Equatable {
    public let cepText: String
    public let addressText: String
    public let districtText: String
    public let cityStateText: String
    
    public init(cepText: String, addressText: String, districtText: String, cityStateText: String) {
        self.cepText = cepText
        self.addressText = addressText
        self.districtText = districtText
        self.cityStateText = cityStateText
    }
}

public final class CEPDetailsViewController: UIViewController {
    private let viewData: CEPDetailsViewData
    
    private(set) public lazy var cepTitleLabel: UILabel = createTitleLabel()
    private(set) public lazy var addressLabel: UILabel = createLabel()
    private(set) public lazy var districtLabel: UILabel = createLabel()
    private(set) public lazy var cityStateLabel: UILabel = createLabel()
    
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
        
        let stackView = UIStackView(arrangedSubviews: [addressLabel, districtLabel, cityStateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
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
        addressLabel.text = viewData.addressText
        districtLabel.text = viewData.districtText
        cityStateLabel.text = viewData.cityStateText
    }
    
    private func configureNavigationBar() {
        title = viewData.cepText
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        return label
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
                          addressText: "ADDRESS",
                          districtText: "DISTRICT",
                          cityStateText: "STATE")
    )
}
