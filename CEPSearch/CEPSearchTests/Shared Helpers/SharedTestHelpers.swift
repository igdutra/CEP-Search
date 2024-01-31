//
//  SharedTestHelpers.swift
//  CEPSearch
//
//  Created by Ivo on 30/01/24.
//

import Foundation
import CEPSearch
import XCTest

// MARK: - Free Funcs

func anyURL(_ host: String = "a-url.com") -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    return components.url ?? URL(string: "https://default-url.com")!
}

struct AnyError: Error, Equatable {
    let message: String
    init(message: String = .init()) {
        self.message = message
    }
}

func anyErrorErased(_ message: String = .init()) -> Error {
    return AnyError(message: message)
}

// MARK: - Models

func makeDetails() -> (model: CEPDetails, data: Data) {
    let details = makeCEPDetailsFixture(cep: "12345-123")
    let data = makeCEPDetailsJSONData(details)
    
    return (details, data)
}

// MARK: - HTTPURLResponse

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

// MARK: - Memory Leak Tracking

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
