//
//  Fixtures.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import Foundation
import CEPSearch

func makeCEPDetailsFixture(cep: String = "00000-000",
                           street: String = "Default Street",
                           complement: String = "",
                           district: String = "Default District",
                           city: String = "Default City",
                           state: String = "Default State"
) -> CEPDetails {
    return CEPDetails(cep: cep,
                      street: street,
                      complement: complement,
                      district: district,
                      city: city,
                      state: state
    )
}

func makeCEPDetailsJSONData(_ details: CEPDetails) -> Data {
    // Encodable structure to mirror the CEPDetails for JSON encoding
    // And not expose CEPDetails to Encodable outside this function scope
    struct EncodableCEPDetails: Encodable {
        let cepDetails: CEPDetails

        enum CodingKeys: String, CodingKey {
            case cep, street, complement, district, city, state
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(cepDetails.cep, forKey: .cep)
            try container.encode(cepDetails.street, forKey: .street)
            try container.encode(cepDetails.complement, forKey: .complement)
            try container.encode(cepDetails.district, forKey: .district)
            try container.encode(cepDetails.city, forKey: .city)
            try container.encode(cepDetails.state, forKey: .state)
        }
    }

    let encoder = JSONEncoder()
    do {
        let encodableItems = EncodableCEPDetails(cepDetails: details)
        let jsonData = try encoder.encode(encodableItems)
        return jsonData
    } catch {
        fatalError("Failed to encode CEPDetails: \(error)")
    }
}
