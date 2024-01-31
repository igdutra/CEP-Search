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
    private static let OK_200: Int = 200
    
    // Note: This way we protec our domain models from API implementation details
    // Payload represents the https://viacep.com.br return
    private struct ViaCepItem: Decodable {
        let cep: String
        let street: String
        let complement: String
        let neighborhood: String
        let city: String
        let state: String
        let ibgeCode: String
        let giaCode: String
        let areaCode: String
        let siafiCode: String
        
        enum CodingKeys: String, CodingKey {
            case cep
            case street = "logradouro"
            case complement = "complemento"
            case neighborhood = "bairro"
            case city = "localidade"
            case state = "uf"
            case ibgeCode = "ibge"
            case giaCode = "gia"
            case areaCode = "ddd"
            case siafiCode = "siafi"
        }
        
        var cepDetails: CEPDetails {
           CEPDetails(cep: cep,
                      street: street,
                      complement: complement,
                      district: neighborhood,
                      city: city,
                      state: state)
        }
    }

    public static func map(_ data: Data, response: HTTPURLResponse) throws -> CEPDetails {
        guard response.statusCode == OK_200 else {
            throw RemoteCEPGetter.Error.invalidData
        }
        
        let details = try JSONDecoder().decode(ViaCepItem.self, from: data).cepDetails
        return details
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
    
    // MARK: - Errors
    
    public enum Error: Swift.Error {
        case invalidData
    }
}
