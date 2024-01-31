//
//  CEPDetailsSnapshotTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import UIKit
// For snapshot tests, expose internal interfaces
@testable import CEPiOS
import CEPSearch

final class CEPDetailsSnapshotTests: XCTestCase {

    func test_cepDetails() {
        let sut = makeSUT()
        
        // Override implementation with this direct data, since this is simply testing the rendering
        sut.loadViewIfNeeded()
        sut.updateUI(with: makeCEPDetailsViewDataFixture())
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "DETAILS_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "DETAILS_dark")
    }
}

// MARK: - Helpers

private extension CEPDetailsSnapshotTests {
    func makeSUT() -> CEPDetailsViewController {
        let details = makeCEPDetailsFixture()
        let viewModel = CEPDetailsViewModel(model: details)
        let viewController = CEPDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
