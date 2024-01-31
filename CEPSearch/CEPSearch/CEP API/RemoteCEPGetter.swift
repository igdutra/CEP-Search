//
//  RemoteCEPGetter.swift
//  CEPSearch
//
//  Created by Ivo on 30/01/24.
//

import Foundation

// Note: this Mapper was added as internal type. It is being tested in integration by the RemoteCEPGetterTests
// No test was broken when it was added, and the Decodable conformance was removed from the CEPDetails Model
enum RemoteCEPGetterMapper {
    public static func map(_ data: Data, response: HTTPURLResponse) throws -> CEPDetails {
        do {
            let details = try JSONDecoder().decode(CEPDetails.self, from: data)
            return details
        } catch {
            throw error // TODO: Define with business the possible failure causes and how the UI should handle it
        }
    }
}

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
            let details = try RemoteCEPGetterMapper.map(data, response: response)
            return details
        } catch {
            throw error
        }
    }
}
