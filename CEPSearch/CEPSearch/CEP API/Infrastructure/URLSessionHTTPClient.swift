//
//  URLSessionHTTPClient.swift
//  CEPSearch
//
//  Created by Ivo on 31/01/24.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.cannotParseResponse)
            }
            
            return (data: data, response: httpResponse)
        } catch {
            throw error
        }
    }
}
