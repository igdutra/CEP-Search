//
//  CEPSearchView.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import SwiftUI
import CEPSearch

// MARK: - Container: Contains the reference to the Loader

public struct CEPSearchViewContainer: View {
    public let cepGetter: CEPGetter
    public var placeholderText: String
    public var buttonText: String
    
    public init(cepGetter: CEPGetter, placeholderText: String, buttonText: String) {
        self.cepGetter = cepGetter
        self.placeholderText = placeholderText
        self.buttonText = buttonText
    }

    public var body: some View {
        CEPSearchView(placeholderText: "Digite o CEP",
                      buttonText: "Procurar Endereço",
                      action: fetchCEPDetails
        )
    }

    private func fetchCEPDetails(cep: String) async {
 
    }
}

// MARK: - Pure View: Depend on Data only so it can be used in the preview

struct CEPSearchView: View {
    @State private var cep: String = ""
    var placeholderText: String
    var buttonText: String
    var action: (String) async -> Void

    var body: some View {
        VStack(spacing: 24) {
            TextField(placeholderText, text: $cep)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(buttonText) {
                Task {
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

// MARK: - Preview

#Preview {
    CEPSearchView(placeholderText: "Digite o CEP", buttonText: "Procurar Endereço", action: { _ in })
}
