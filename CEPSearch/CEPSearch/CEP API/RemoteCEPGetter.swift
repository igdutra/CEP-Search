//
//  RemoteCEPGetter.swift
//  CEPSearch
//
//  Created by Ivo on 30/01/24.
//

import Foundation

public final class RemoteCEPGetter {
    private let client: HTTPClient
    private let url: URL
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func getCEPDetails(for cep: String) async throws -> CEPDetails {
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
