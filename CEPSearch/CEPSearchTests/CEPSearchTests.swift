//
//  CEPSearchTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import CEPSearch

final class RemoteCEPGetter {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

final class HTTPClient {
    // Note: ReceivedMessage is the method signature
    enum ReceivedMessage: Equatable {
        case load(URL)
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
}

final class RemoteCEPGetterTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        let _ = RemoteCEPGetter(client: client)
        
        XCTAssert(client.receivedMessages.isEmpty)
    }
}
