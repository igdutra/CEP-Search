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
    typealias Observer<T> = (T) -> Void
    
    private let model: CEPDetails
    var onViewDataUpdated: Observer<CEPDetailsViewData>?

    init(model: CEPDetails) {
        self.model = model
    }

    // Note: Here, in the presentation layer, we could add Localization for the Titles, like "Address", "District" etc.
    public func formatData() {
        let address = model.complement.isEmpty ? model.street : "\(model.street), \(model.complement)"
        let cityState = "\(model.city), \(model.state)"
        let viewData = CEPDetailsViewData(cepText: model.cep,
                                          addressTexts: InfoStrings(title: "Address", info: address),
                                          districtTexts: InfoStrings(title: "District", info: model.district),
                                          cityStateTexts: InfoStrings(title: "City/State", info: cityState))
        onViewDataUpdated?(viewData)
    }
}

public final class CEPDetailsViewController: UIViewController {
    private var viewModel: CEPDetailsViewModel
    
    private(set) public lazy var cepTitleLabel: UILabel = createTitleLabel()
    private(set) public lazy var addressView: CepInfoView = .init()
    private(set) public lazy var districtView: CepInfoView = .init()
    private(set) public lazy var cityStateView: CepInfoView = .init()
    
    init(viewModel: CEPDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Bind and fire viewModel
        bindViewModel()
        viewModel.formatData()
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
    
    private func bindViewModel() {
        viewModel.onViewDataUpdated = { [weak self] viewData in
            DispatchQueue.main.async {
                self?.updateUI(with: viewData)
            }
        }
    }
    
    func updateUI(with viewData: CEPDetailsViewData) {
        title = viewData.cepText
        cepTitleLabel.text = viewData.cepText
        
        addressView.titleLabel.text = viewData.addressTexts.title
        addressView.infoLabel.text = viewData.addressTexts.info
        
        districtView.titleLabel.text = viewData.districtTexts.title
        districtView.infoLabel.text = viewData.districtTexts.info
        
        cityStateView.titleLabel.text = viewData.cityStateTexts.title
        cityStateView.infoLabel.text = viewData.cityStateTexts.info
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
    CEPDetailsUIComposer.detailsComposed(with:
        CEPDetails(cep: "12345-678",
                   street: "Example Street",
                   complement: "Apt 101",
                   district: "Example District",
                   city: "Example City",
                   state: "EX")
    )
}

//    CEPDetailsViewController(viewData:
//       CEPDetailsViewData(cepText: "CEP",
//                          addressTexts: InfoStrings(title: "Address", info: "Example Street, Apt 101"),
//                          districtTexts: InfoStrings(title: "District", info: "Example District"),
//                          cityStateTexts: InfoStrings(title: "City", info: "Example City, EX"))
//    )

//let viewData = CEPDetailsViewData(cepText: "CEP: 12345-678",
//                                  addressTexts: InfoStrings(title: "Address", info: "Example Street, Apt 101"),
//                                  districtTexts: InfoStrings(title: "District", info: "Example District"),
//                                  cityStateTexts: InfoStrings(title: "City", info: "Example City, EX"))
