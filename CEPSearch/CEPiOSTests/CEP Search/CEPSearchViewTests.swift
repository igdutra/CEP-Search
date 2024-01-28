//
//  CEPSearchViewTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import CEPiOS

final class CEPSearchViewTests: XCTestCase {

    func test_init_doesNotRequestCEP() {
        let spy = CEPGetterSpy()
        let view = CEPSearchViewContainer(cepGetter: spy,
                                          placeholderText: .init(),
                                          buttonText: .init())
        
        XCTAssertEqual(spy.receivedMessages, [], "Expected no CEP request on view initialization")
    }

}
