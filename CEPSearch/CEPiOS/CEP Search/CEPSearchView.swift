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
    @Binding var nextView: AnyView // TODO: Search for another type erasures
    var viewData: CEPSearchViewData
    private var action: (String) async -> Bool
    // Note: tried to move this state to the viewModel through custom Binding, where it belongs, but did not work.
    // TODO: Fix that. 
    @State private var shouldPresentNextScreen: Bool = false
    
    public init(cep: Binding<String>,
                nextView: Binding<AnyView>,
                viewData: CEPSearchViewData,
                action: @escaping (String) async -> Bool) {
        self._cep = cep
        self._nextView = nextView
        self.viewData = viewData
        self.action = action
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                TextField(viewData.placeholderText, text: $cep)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Could create SwiftUI Component for this Button
                // And move it to a Design System
                Button(viewData.buttonText) {
                    Task {
                        shouldPresentNextScreen = await action(cep)
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding()
            .navigationDestination(isPresented: $shouldPresentNextScreen,
                                   destination: {
                nextView
            })
        }
    }
}

// MARK: - Previews - Testing Only

// Note: Container is getting poluted, might study to move that elsewhere

// Note: Create a Container for the Preview so we can preview correctly in a live preview how the TextField works
struct CEPSearchView_Previews: PreviewProvider {
    // Nested Struct capable of maintaining its own state.
    // It's not limited by the static context of the PreviewProvider
    struct CEPSearchViewContainer: View {
        @State private var cep: String = ""
        
        var body: some View {
            CEPSearchView(cep: $cep,
                          nextView: .constant(AnyView(TestView())),
                          viewData: CEPSearchViewData(placeholderText: "Digite o CEP",
                                                      buttonText: "Procurar Endereço"),
                          action: { cep in
                print("CEP typed: ", cep)
                return false
            })
        }
    }
    
    struct TestView: View {
        var body: some View {
            Text("Hello, SwiftUI!!!!!!!!! ")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
    }

    static var previews: some View {
        CEPSearchViewContainer()
    }
}
