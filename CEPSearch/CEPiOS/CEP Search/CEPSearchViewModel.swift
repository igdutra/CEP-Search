//
//  CEPSearchViewModel.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

import CEPSearch

final class CEPSearchViewModel {
    private var cepGetter: CEPGetter
    var cep: String = .init()
    
    // Note: Retrieve localized values
    var viewData: CEPSearchViewData = {
        CEPSearchViewData(placeholderText: "Digite o CEP",
                          buttonText: "Procurar Endereço")
    }()
    
    init(cepGetter: CEPGetter) {
        self.cepGetter = cepGetter
    }
    
    func fetchCEPDetails(cep: String) async {
        let _ = try? await cepGetter.getCEPDetails(for: cep)
        // TODO: Navigation
    }
}
