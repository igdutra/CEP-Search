//
//  URLSessionHTTPClientTests.swift
//  CEPSearch
//
//  Created by Ivo on 31/01/24.
//

import XCTest
import CEPSearch

/* Notes on URLSessionHTTPClientTests
 
 This class was completely imported due to its decoupled nature.
 This class simply obey commands, and deals with infrastructure
 Original implementation can be found here:
 https://github.com/igdutra/NASA-Gallery/blob/main/NASAGallery/NASAGalleryTests/Gallery%20API/URLSessionHTTPClientTests.swift
*/

final class URLSessionHTTPClientTests: XCTestCase {
    
    // MARK: - SetUp & TearDown
    
    override func setUp() async throws {
        try await super.setUp()
        URLProtocolStub.startInterceptingRequests()
    }
    
    override func tearDown() async throws {
        URLProtocolStub.stopInterceptingRequests()
        try await super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_getFromURL_performsGETRequestWithURL() async {
        let url = anyURL()
        URLProtocolStub.stub(data: nil, response: nil, error: AnyError())
        
        var observedRequest: URLRequest?
        
        URLProtocolStub.captureRequest { request in
            observedRequest = request
        }
        
        let sut = makeSUT()
        
        let _ = try? await sut.getData(from: url)
        
        XCTAssertNotNil(observedRequest)
        XCTAssertEqual(observedRequest?.url, url)
        XCTAssertEqual(observedRequest?.httpMethod, "GET")
    }
    
    // MARK: Error Cases
    
    func test_getFromURL_onRequestError_fails() async {
        // Needs to be NSError
        let expectedError = NSError(domain: "failsOnRequestError", code: 13)
        let url = anyURL()
     
        URLProtocolStub.stub(data: nil, response: nil, error: expectedError)
        let sut = makeSUT()
        
        await assertFailsWithNSError(expectedError) {
            _ = try await sut.getData(from: url)
        }
    }
    
    func test_getFromURL_onNonHTTPURLResponse_failsWithURLError() async {
        let validReturn = Data()
        let url = anyURL()
        let nonHTTPResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
     
        URLProtocolStub.stub(data: validReturn, response: nonHTTPResponse, error: nil)
        let sut = makeSUT()
        
        await assertFailsWith(URLError(.cannotParseResponse)) {
            _ = try await sut.getData(from: url)
        }
    }
    
    // MARK: Success Cases
    
    func test_getFromURL_withNilDataOnHTTPURLResponse_succeedsWithEmptyData() async throws {
        let returnedNilData: Data? = nil
        let expectedEmptyData = Data()
        let url = anyURL()
        let validResponse = HTTPURLResponse(url: url,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)!
     
        URLProtocolStub.stub(data: returnedNilData, response: validResponse, error: nil)
       
        try await assertGetData(willReturn: (data: expectedEmptyData, response: validResponse))
    }
    
    func test_getFromURL_withDataOnHTTPURLResponse_succeeds() async throws {
        let expectedReturn = makeDetails().data
        let url = anyURL()
        let validResponse = HTTPURLResponse(url: url,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)!
     
        URLProtocolStub.stub(data: expectedReturn, response: validResponse, error: nil)
        
        try await assertGetData(willReturn: (data: expectedReturn, response: validResponse))
    }
}

// MARK: - Helpers
private extension URLSessionHTTPClientTests {
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let sut = URLSessionHTTPClient()
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
    
    func assertFailsWithNSError(_ expectedNSError: NSError,
                                action: () async throws -> Void,
                                file: StaticString = #filePath, line: UInt = #line) async {
        do {
            try await action()
            XCTFail("Expected Error but returned successfully instead", file: file, line: line)
        } catch let error as NSError {
            XCTAssertEqual(error.code, expectedNSError.code, file: file, line: line)
            XCTAssertEqual(error.domain, expectedNSError.domain, file: file, line: line)
        } catch {
            XCTFail("Should throw expectedError but threw \(error) instead", file: file, line: line)
        }
    }
    
    func assertFailsWith<ErrorType: Error>(_ expectedError: ErrorType,
                                           action: () async throws -> Void,
                                           file: StaticString = #filePath, line: UInt = #line) async where ErrorType: Equatable {
        do {
            try await action()
            XCTFail("Expected Error but returned successfully instead", file: file, line: line)
        } catch let error as ErrorType {
            XCTAssertEqual(error, expectedError, file: file, line: line)
        } catch {
            XCTFail("Should throw expectedError but threw \(error) instead", file: file, line: line)
        }
    }
    
    func assertGetData(willReturn expectedReturn: (data: Data, response: HTTPURLResponse),
                       file: StaticString = #filePath, line: UInt = #line) async throws {
        let url = anyURL()
        let sut = makeSUT()

        do {
            let receivedReturn = try await sut.getData(from: url)
            
            XCTAssertEqual(receivedReturn.data, expectedReturn.data, file: file, line: line)
            XCTAssertEqual(receivedReturn.response.url, expectedReturn.response.url, file: file, line: line)
            XCTAssertEqual(receivedReturn.response.statusCode, expectedReturn.response.statusCode, file: file, line: line)
        } catch {
            XCTFail("Should succeed but threw \(error) instead", file: file, line: line)
        }
    }
}

// MARK: - URLProtocolStub

private extension URLSessionHTTPClientTests {
    private class URLProtocolStub: URLProtocol {
        // MARK: Properties and Helpers
        
        private static var stub: Stub?
        
        private static var captureRequest: ((URLRequest) -> Void)?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func captureRequest(observer: @escaping (URLRequest) -> Void) {
            captureRequest = observer
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            captureRequest = nil
        }
        
        // MARK: - URLProtocol
        
        override class func canInit(with request: URLRequest) -> Bool {
            captureRequest?(request)
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            guard let stub = URLProtocolStub.stub else {
                // XCTFail() was not being displayed correctly, better crash instead.
                // Missing client didfinishloading
                fatalError("Test needs a stubbed response")
            }
            
            if let data = stub.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = stub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() { }
    }
}
