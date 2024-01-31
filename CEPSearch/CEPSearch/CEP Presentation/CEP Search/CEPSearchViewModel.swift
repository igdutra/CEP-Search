//
//  CEPSearchViewModel.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

import Foundation

public class CEPSearchViewData {
    public var placeholderText: String
    public var buttonText: String
    
    public init(placeholderText: String, buttonText: String) {
        self.placeholderText = placeholderText
        self.buttonText = buttonText
    }
}

public final class CEPSearchViewModel {
    private var cepGetter: CEPGetter
    public var cep: String = .init()
    
    // Note: Retrieve localized values
    public var viewData: CEPSearchViewData = {
        CEPSearchViewData(placeholderText: "Digite o CEP",
                          buttonText: "Procurar Endereço")
    }()
    
    public init(cepGetter: CEPGetter) {
        self.cepGetter = cepGetter
    }
    
    public func fetchCEPDetails(cep: String) async -> CEPDetails? {
        return try? await cepGetter.getCEPDetails(for: cep)
    }
}
