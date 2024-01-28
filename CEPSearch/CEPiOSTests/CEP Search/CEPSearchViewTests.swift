//
//  CEPSearchViewTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import CEPiOS

/* NOTE:
 
 - Snapshot tests are used to test the rendering of the view.
   They are also valuable to detect and protec the codebase from any breaking changes in iOS updates
 
 - Whereas this Unit Tests are used to asser the behavior of the view: in this case, assert that the request is made when pressing the button
 
*/

final class CEPSearchViewTests: XCTestCase {

    func test_init_doesNotRequestCEP() {
        let spy = CEPGetterSpy()
        let _ = CEPSearchViewContainer(cepGetter: spy,
                                       placeholderText: .init(),
                                       buttonText: .init())
        
        XCTAssertEqual(spy.receivedMessages, [], "Expected no CEP request on view initialization")
    }

}
