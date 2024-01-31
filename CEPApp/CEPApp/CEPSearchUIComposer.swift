//
//  CEPSearchUIComposer.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

import SwiftUI
import CEPSearch
import CEPiOS

public enum CEPSearchUIComposer {
    public static func composeView(cepGetter: CEPGetter,
                                   nextViewToPresent: @escaping () -> AnyView) -> CEPSearchView {
        let viewModel = CEPSearchViewModel(cepGetter: cepGetter)
        
        // Bind the ViewModel and the View
        // Keeping ViewModel agnostic
        let binding = Binding<String>(
            get: { viewModel.cep },
            set: { viewModel.cep = $0 }
        )
        
        return CEPSearchView(cep: binding,
                             viewData: viewModel.viewData,
                             action: viewModel.fetchCEPDetails,
                             nextViewToPresent: nextViewToPresent)
    }
}
