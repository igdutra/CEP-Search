//
//  CEPSearchViewSnapshotTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import UIKit
import SwiftUI
import CEPiOS


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
        let view = CEPSearchView(placeholderText: "Digite o CEP", buttonText: "Procurar Endereço")
        let hostingController = UIHostingController(rootView: view)
        return hostingController
    }
}
