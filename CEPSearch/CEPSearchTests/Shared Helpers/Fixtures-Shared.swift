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
    let json: [String: String] = [
        "cep": details.cep,
        "logradouro": details.street,
        "complemento": details.complement,
        "bairro": details.district,
        "localidade": details.city,
        "uf": details.state,
        "ibge": "1111111",
        "gia": "1111",
        "ddd": "11",
        "siafi": "1111",
    ]
    
    return try! JSONSerialization.data(withJSONObject: json)
}
