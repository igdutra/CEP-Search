//
//  CEPGetterEndpointTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 31/01/24.
//

import XCTest
import CEPSearch

final class CEPGetterEndpointTests: XCTestCase {

    func test_cepGetter_endpointURL() {
        let cep = "12345-123"
        let baseURL = URL(string: "https://base-url.com")!
        
        let received = CEPGetterEndpoint.get(cep).url(baseURL: baseURL)
        let expected = URL(string: "https://base-url.com/12345-123/json")!
        
        XCTAssertEqual(received, expected)
    }
}
