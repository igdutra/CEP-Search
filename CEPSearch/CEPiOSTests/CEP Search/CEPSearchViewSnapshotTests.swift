//
//  CEPSearchViewSnapshotTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import UIKit

final class CEPSearchViewSnapshotTests: XCTestCase {

    func test_feedWithFailedImageLoading() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "SEARCH_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "SEARCH_dark")
    }
}

// MARK: - Helpers

private extension CEPSearchViewSnapshotTests {
    func makeSUT() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .green
        return view
    }
}
