//
//  CEPDetailsViewControllerTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import CEPiOS
import CEPSearch

final class CEPDetailsViewControllerTests: XCTestCase {
    
    func test_labelTexts_withKnownViewData() {
        let viewData = CEPDetailsViewData(cepText: "CEP: 12345-678",
                                          addressText: "Address: Example Street, Apt 101",
                                          districtText: "District: Example District",
                                          cityStateText: "City/State: Example City, EX")
        
        let sut = makeSUT(viewData: viewData)
        
        // Force view lifecycle
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.cepText(), viewData.cepText)
        XCTAssertEqual(sut.addressText(), viewData.addressText)
        XCTAssertEqual(sut.districtText(), viewData.districtText)
        XCTAssertEqual(sut.cityStateText(), viewData.cityStateText)
    }
}

// MARK: - Helpers

private extension CEPDetailsViewControllerTests {
    func makeSUT(viewData: CEPDetailsViewData) -> CEPDetailsViewController {
        let viewController = CEPDetailsViewController(viewData: viewData)
        trackForMemoryLeaks(viewController)
        return viewController
    }
}

