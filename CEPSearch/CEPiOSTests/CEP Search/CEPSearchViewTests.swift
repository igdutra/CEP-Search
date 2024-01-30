//
//  CEPSearchViewTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import CEPiOS // Test the module through its public interface

/* NOTE:
 
 - Snapshot tests are used to test the rendering of the view.
   They are also valuable to detect and protec the codebase from any breaking changes in iOS updates
 
 - Whereas this Unit Tests are used to asser the behavior of the view: in this case, assert that the request is made when pressing the button
 
*/

final class CEPSearchViewTests: XCTestCase {

    func test_init_doesNotRequestCEP() {
        let (_, spy) = makeSUT()
        
        XCTAssertEqual(spy.receivedMessages, [], "Expected no CEP request on view initialization")
    }
    
//  TODO: Study how to test SwiftUI Views
//    func test_buttonPressed_requestCEP() { }
    
//    If this was a UIKit view, we could leverage of some helpers like the ones below, to simulate an actual tap in a button.
/*
 extension UIControl {
     func simulate(event: UIControl.Event) {
         allTargets.forEach { target in
             actions(forTarget: target, forControlEvent: event)?.forEach {
                 (target as NSObject).perform(Selector($0))
             }
         }
     }
 }
 
 extension UIButton {
     func simulateTap() {
         simulate(event: .touchUpInside)
     }
 }

 */
}

// MARK: - Helpers

private extension CEPSearchViewTests {
    func makeSUT() -> (sut: CEPSearchViewContainer, spy: CEPGetterSpy) {
        let spy = CEPGetterSpy()
        let sut = CEPSearchViewContainer(cepGetter: spy,
                                         placeholderText: .init(),
                                         buttonText: .init())
        
        trackForMemoryLeaks(spy)
//        trackForMemoryLeaks(sut)
        // TODO: Search for a good way to add memory leak tracking to SwiftUI View.
        // It is a struct, but contains reference types inside 
        
        return (sut, spy)
    }
}
