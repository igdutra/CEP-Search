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
        // Given known view data
        let viewData = CEPDetailsViewData(cepText: "CEP: 12345-678",
                                          addressText: "Address: Example Street, Apt 101",
                                          districtText: "District: Example District",
                                          cityStateText: "City/State: Example City, EX")
        
        let viewController = CEPDetailsViewController(viewData: viewData)
        
        // Force view lifecycle
        viewController.loadViewIfNeeded()
        
        XCTAssertEqual(viewController.cepLabel.text, viewData.cepText)
        XCTAssertEqual(viewController.addressLabel.text, viewData.addressText)
        XCTAssertEqual(viewController.districtLabel.text, viewData.districtText)
        XCTAssertEqual(viewController.cityStateLabel.text, viewData.cityStateText)
    }
}
