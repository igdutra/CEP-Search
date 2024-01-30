//
//  CEPSearchView.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import SwiftUI
import CEPSearch

//// MARK: - Container: Contains the reference to the Loader
//
//public struct CEPSearchViewContainer: View {
//    public let cepGetter: CEPGetter
//    public var placeholderText: String
//    public var buttonText: String
//    
//    public init(cepGetter: CEPGetter, placeholderText: String, buttonText: String) {
//        self.cepGetter = cepGetter
//        self.placeholderText = placeholderText
//        self.buttonText = buttonText
//    }
//
//    public var body: some View {
//        CEPSearchView(placeholderText: "Digite o CEP",
//                      buttonText: "Procurar Endereço",
//                      action: fetchCEPDetails
//        )
//    }
//
//    private func fetchCEPDetails(cep: String) async {
// 
//    }
//}

struct CEPSearchViewData {
    var placeholderText: String
    var buttonText: String
}

// MARK: - Pure View: Depend on Data only so it can be used in the preview

struct CEPSearchView: View {
    @Binding var cep: String
    var viewData: CEPSearchViewData
    private var action: (String) async -> Void
    
    init(cep: Binding<String>, viewData: CEPSearchViewData, action: @escaping (String) async -> Void) {
        self._cep = cep
        self.viewData = viewData
        self.action = action
    }

    var body: some View {
        VStack(spacing: 24) {
            TextField(viewData.placeholderText, text: $cep)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(viewData.buttonText) {
                Task {
                    print(cep)
                    await action(cep)
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}

// MARK: - Previews

// Note: Create a Container for the Preview so we can preview correctly in a live preview how the TextField works
struct CEPSearchView_Previews: PreviewProvider {
    // Nested Struct capable of maintaining its own state.
    // It's not limited by the static context of the PreviewProvider
    struct CEPSearchViewContainer: View {
        @State private var cep: String = ""

        var body: some View {
            CEPSearchView(cep: $cep,
                          viewData: CEPSearchViewData(placeholderText: "Digite o CEP",
                                                      buttonText: "Procurar Endereço"),
                          action: { cep in
                print("CEP typed: ", cep)
            })
        }
    }

    static var previews: some View {
        CEPSearchViewContainer()
    }
}
