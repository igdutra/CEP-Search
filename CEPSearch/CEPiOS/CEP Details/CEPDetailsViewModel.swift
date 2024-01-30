//
//  CEPDetailsViewModel.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

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

public final class CEPDetailsViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let model: CEPDetails
    var onViewDataUpdated: Observer<CEPDetailsViewData>?

    init(model: CEPDetails) {
        self.model = model
    }
    
    public static func map(_ details: CEPDetails) -> CEPDetailsViewData {
        let address = details.complement.isEmpty ? details.street : "\(details.street), \(details.complement)"
        let cityState = "\(details.city), \(details.state)"
        return CEPDetailsViewData(cepText: details.cep,
                                  addressTexts: InfoStrings(title: "Address", info: address),
                                  districtTexts: InfoStrings(title: "District", info: details.district),
                                  cityStateTexts: InfoStrings(title: "City/State", info: cityState))
    }

    // Note: Here, in the presentation layer, we could add Localization for the Titles, like "Address", "District" etc.
    public func formatData() {
        let viewData = CEPDetailsViewModel.map(model)
        onViewDataUpdated?(viewData)
    }
}

