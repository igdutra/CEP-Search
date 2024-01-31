//
//  CEPSearchViewModel.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

import Foundation
import SwiftUI // TODO: remove this import with generics. Abstract the AnyView return into its own type

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
    private var nextViewToPresent: (CEPDetails) -> AnyView
    public var cep: String = .init()

    // Note: Retrieve localized values
    public var viewData: CEPSearchViewData = {
        CEPSearchViewData(placeholderText: "Digite o CEP",
                          buttonText: "Procurar Endereço")
    }()
    
    public init(cepGetter: CEPGetter,
                nextViewToPresent: @escaping (CEPDetails) -> AnyView) {
        self.cepGetter = cepGetter
        self.nextViewToPresent = nextViewToPresent
    }
    
    public func fetchCEPDetails(cep: String) async {
        do {
            let details = try await cepGetter.getCEPDetails(for: cep)
            let nextView = nextViewToPresent(details)
        } catch {
            print("TODO: Handle error in the UI!\n", error.localizedDescription)
        }
    }
}
