//
//  CEPDetailsSnapshotTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import UIKit
import CEPiOS

final class CEPDetailsSnapshotTests: XCTestCase {

    func test_cepDetails() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "DETAILS_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "DETAILS_dark")
    }
}

// MARK: - Helpers

private extension CEPDetailsSnapshotTests {
    func makeSUT() -> CEPDetailsViewController {
        let details = makeCEPDetailsViewDataFixture()
        let viewController = CEPDetailsViewController(viewData: details)
        return viewController
    }
}
