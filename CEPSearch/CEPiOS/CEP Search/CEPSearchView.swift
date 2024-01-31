//
//  CEPSearchView.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import SwiftUI
import CEPSearch

// MARK: - Pure View: Depend on Data only so it can be used in the preview

public struct CEPSearchView: View {
    @Binding var cep: String
    var viewData: CEPSearchViewData
    private var action: (String) async -> Void
    private var onButtonPressed: () -> Void
    
    public init(cep: Binding<String>, viewData: CEPSearchViewData, action: @escaping (String) async -> Void, onButtonPressed: @escaping () -> Void) {
        self._cep = cep
        self.viewData = viewData
        self.action = action
        self.onButtonPressed = onButtonPressed
    }

    public var body: some View {
        VStack(spacing: 24) {
            TextField(viewData.placeholderText, text: $cep)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Could create SwiftUI Component for this Button
            // And move it to a Design System
            Button(viewData.buttonText) {
                Task {
                    await action(cep)
                    onButtonPressed()
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
            },   onButtonPressed: {
                print("Button was pressed")
            })
        }
    }

    static var previews: some View {
        CEPSearchViewContainer()
    }
}
