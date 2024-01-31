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
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func getCEPDetails(for cep: String) async throws {
        // TODO: add URL mapper to add CEP
        client.getData(from: url)
    }
}

final class HTTPClient {
    // Note: ReceivedMessage is the method signature
    enum ReceivedMessage: Equatable {
        case getData(URL)
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    func getData(from url: URL) {
        
        receivedMessages.append(.getData(url))
    }
}

final class RemoteCEPGetterTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        let _ = RemoteCEPGetter(url: anyURL(), client: client)
        
        XCTAssert(client.receivedMessages.isEmpty)
    }
    
    func test_getCEP_requestDataFromURL() async {
        let url = anyURL("a-url")
        let client = HTTPClient()
        let sut = RemoteCEPGetter(url: url, client: client)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: cep)
        
        _ = try? await sut.getCEPDetails(for: .init())
        
        XCTAssertEqual(client.receivedMessages, [.getData(expectedURL)])
    }
}

// MARK: - Helpers
private extension RemoteCEPGetterTests {
    func expectedURL(url: URL, cep: String) -> URL {
        // For now, return url
        return url
    }
}
