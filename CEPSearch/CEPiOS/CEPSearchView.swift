//
//  CEPSearchView.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import SwiftUI

public struct CEPSearchView: View {
    @State private var cep: String = ""
    
    public init() {
        
    }

    public var body: some View {
        VStack(spacing: 20) {
            TextField("Digite o CEP", text: $cep)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Procurar Endereço") {
                // Implement search functionality here
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}
