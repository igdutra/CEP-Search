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
    
    func getCEPDetails(for cep: String) async throws -> CEPDetails {
        // TODO: add URL mapper to add CEP
        do {
            let (data, response) = try await client.getData(from: url)
            let details = try JSONDecoder().decode(CEPDetails.self, from: data)
            return details
        } catch {
            throw error
        }
    }
}

public protocol HTTPClient {
    func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse)
}

final class HTTPClientSpy: HTTPClient {
    enum ReceivedMessage: Equatable {
        case getData(URL)
    }
    private(set) var receivedMessages = [ReceivedMessage]()
    
    struct SuccessResponse: Equatable {
        let response: HTTPURLResponse
        let data: Data
    }
    typealias Result = Swift.Result<SuccessResponse, Error>

    private var stub: (url: URL, result: Result)?
    
    func stub(url: URL, result: Result) {
        stub = (url, result)
    }
    
    // MARK: - Interface

    // Function to handle data fetching, simulating async network calls
    func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        receivedMessages.append(.getData(url))
        
        guard let stub = self.stub, stub.url == url else {
            fatalError("No stub for \(url)")
        }
        
        switch stub.result {
        case let .success(response):
            return (response.data, response.response)
        case let .failure(error):
            throw error
        }
    }
}

final class RemoteCEPGetterTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let _ = RemoteCEPGetter(url: anyURL(), client: client)
        
        XCTAssert(client.receivedMessages.isEmpty)
    }
    
    func test_getCEP_requestDataFromURL() async {
        let url = anyURL("a-url")
        let client = HTTPClientSpy()
        let sut = RemoteCEPGetter(url: url, client: client)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: cep)
        client.stub(url: expectedURL, result: .failure(AnyError()))
        
        _ = try? await sut.getCEPDetails(for: .init())
        
        XCTAssertEqual(client.receivedMessages, [.getData(expectedURL)])
    }
    
    // MARK: - Error Cases
    
    func test_getCEP_onClientError_failsWithError() async {
        let url = anyURL("a-url")
        let client = HTTPClientSpy()
        let sut = RemoteCEPGetter(url: url, client: client)
        let expectedURL = expectedURL(url: url, cep: .init())
        let expectedError = AnyError(message: "Client Error")
        client.stub(url: expectedURL, result: .failure(expectedError))
        
        do {
            _ = try await sut.getCEPDetails(for: .init())
            XCTFail("Expected Error but returned successfully instead")
        } catch let error as AnyError {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Expected AnyError but returned \(error) instead")
        }
    }
    
    // Note: Could define especific error cases
    
    // MARK: - Success Cases
    
    func test_getCEP_on200HTTPResponse_succeedsWithDetail() async {
        let url = anyURL("a-url")
        let client = HTTPClientSpy()
        let sut = RemoteCEPGetter(url: url, client: client)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: .init())
      
        let (expectedDetails, expectedJSONData) = makeDetails()
        let clientResponse = SuccessResponse(response: HTTPURLResponse(statusCode: 200),
                                             data: expectedJSONData)
        client.stub(url: expectedURL, result: .success(clientResponse))
        
        do {
            let details = try await sut.getCEPDetails(for: cep)
            XCTAssertEqual(details, expectedDetails)
        } catch {
            XCTFail("Expected Success but returned \(error) instead")
        }
    }
    
}

// MARK: - Helpers
private extension RemoteCEPGetterTests {
    typealias SuccessResponse = HTTPClientSpy.SuccessResponse
    
    func expectedURL(url: URL, cep: String) -> URL {
        // For now, return url
        return url
    }
}
