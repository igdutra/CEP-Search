//
//  CEPSearchView.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import SwiftUI

public struct CEPSearchView: View {
    @State private var cep: String = ""
    public var placeholderText: String
    public var buttonText: String
    
    public init(placeholderText: String, buttonText: String) {
        self.placeholderText = placeholderText
        self.buttonText = buttonText
    }
    
    // MARK: - View

    public var body: some View {
        VStack(spacing: 20) {
            TextField(placeholderText, text: $cep)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(buttonText) {
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
