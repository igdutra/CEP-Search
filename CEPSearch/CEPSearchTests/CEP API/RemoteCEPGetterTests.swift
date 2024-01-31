//
//  RemoteCEPGetterTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 28/01/24.
//

import XCTest
import CEPSearch

final class RemoteCEPGetterTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssert(client.receivedMessages.isEmpty)
    }
    
    func test_getCEP_requestDataFromURL() async {
        let url = anyURL("a-url")
        let (sut, client) = makeSUT(url: url)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: cep)
        client.stub(url: expectedURL, result: .failure(AnyError()))
        
        _ = try? await sut.getCEPDetails(for: cep)
        
        XCTAssertEqual(client.receivedMessages, [.getData(expectedURL)])
    }
    
    // MARK: - Error Cases
    
    func test_getCEP_onClientError_failsWithError() async {
        let url = anyURL("a-url")
        let (sut, client) = makeSUT(url: url)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: cep)
        let expectedError = AnyError(message: "Client Error")
        client.stub(url: expectedURL, result: .failure(expectedError))
        
        do {
            _ = try await sut.getCEPDetails(for: cep)
            XCTFail("Expected Error but returned successfully instead")
        } catch let error as AnyError {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Expected AnyError but returned \(error) instead")
        }
    }
    
    func test_getCEP_onNonHTTP200Response_failsWithInvalidData() async {
        let url = anyURL("a-url")
        let (sut, client) = makeSUT(url: url)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: cep)
        let expectedError: RemoteCEPGetter.Error = .invalidData
        let clientResponse = SuccessResponse(response: HTTPURLResponse(statusCode: 300),
                                             data: Data())
        client.stub(url: expectedURL, result: .success(clientResponse))
        
        do {
            _ = try await sut.getCEPDetails(for: cep)
            XCTFail("Expected Error but returned successfully instead")
        } catch let error as RemoteCEPGetter.Error {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Expected AnyError but returned \(error) instead")
        }
    }
    
    // MARK: - Success Cases
    
    func test_getCEP_on200HTTPResponse_succeedsWithDetail() async {
        let url = anyURL("a-url")
        let (sut, client) = makeSUT(url: url)
        let cep = "12345-123"
        let expectedURL = expectedURL(url: url, cep: cep)
      
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
    
    func makeSUT(url: URL = anyURL(), file: StaticString = #file, line: UInt = #line) -> (sut: RemoteCEPGetter, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteCEPGetter(baseURL: url, client: client)
        
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, client)
    }
    
    // Helper function to extract the implicit CEPGetterEndpoint
    func expectedURL(url: URL, cep: String) -> URL {
        let url = CEPGetterEndpoint.get(cep).url(baseURL: url)
        return url
    }
}

// MARK: - Spy

private extension RemoteCEPGetterTests {
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

}
