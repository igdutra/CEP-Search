//
//  Fixtures.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

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
