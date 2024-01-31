//
//  RemoteCEPGetter.swift
//  CEPSearch
//
//  Created by Ivo on 30/01/24.
//

import Foundation

public final class RemoteCEPGetter {
    private let client: HTTPClient
    private let baseURL: URL
    
    public init(baseURL: URL, client: HTTPClient) {
        self.baseURL = baseURL
        self.client = client
    }
    
    public func getCEPDetails(for cep: String) async throws -> CEPDetails {
        let url = CEPGetterEndpoint.get(cep).url(baseURL: baseURL)
        
        let (data, response) = try await client.getData(from: url)
        let details = try RemoteCEPGetterMapper.map(data, response: response)
        
        return details
    }
    
    // MARK: - Errors
    
    public enum Error: Swift.Error {
        case invalidData
    }
}
