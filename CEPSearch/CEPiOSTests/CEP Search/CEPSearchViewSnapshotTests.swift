//
//  CEPSearchViewSnapshotTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import UIKit
import SwiftUI

struct CEPSearchView: View {
    @State private var cep: String = ""

    var body: some View {
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

final class CEPSearchViewSnapshotTests: XCTestCase {

    func test_searchCEP() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "SEARCH_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "SEARCH_dark")
    }
}

// MARK: - Helpers

private extension CEPSearchViewSnapshotTests {
    func makeSUT() -> UIViewController {
        let view = CEPSearchView()
        let hostingController = UIHostingController(rootView: view)
        return hostingController
    }
}
