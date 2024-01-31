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
                                   nextViewToPresent: @escaping (CEPDetails) -> AnyView) -> CEPSearchView {
        let viewModel = CEPSearchViewModel(cepGetter: cepGetter,
                                           nextViewToPresent: nextViewToPresent)
        
        // Bind the ViewModel and the View
        // Keeping ViewModel agnostic
        let cepBinding = Binding<String>(
            get: { viewModel.cep },
            set: { viewModel.cep = $0 }
        )
        
        let viewBinding = Binding<AnyView>(
            get: { viewModel.nextView },
            set: { viewModel.nextView = $0 }
        )
        
        
        // Note: at latest point in time, I was not able to get this binding to work as intended
//        let shouldPresentNextScreenBinding = Binding<Bool>(
//            get: { viewModel.shouldPresentNextScreen },
//            set: { viewModel.shouldPresentNextScreen = $0 }
//        )
        
        return CEPSearchView(cep: cepBinding,
                             nextView: viewBinding,
                             viewData: viewModel.viewData,
                             action: viewModel.fetchCEPDetails)
    }
}
