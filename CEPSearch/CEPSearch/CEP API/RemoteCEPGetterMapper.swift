//
//  RemoteCEPGetterMapper.swift
//  CEPSearch
//
//  Created by Ivo on 31/01/24.
//

import Foundation

// Note: this Mapper was added as internal type. It is being tested in integration by the RemoteCEPGetterTests
// No test was broken when it was added, and the Decodable conformance was removed from the CEPDetails Model
enum RemoteCEPGetterMapper {
    private static let OK_200: Int = 200 // Avoid Magic numbers
    
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
