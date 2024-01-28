//
//  Fixtures.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import CEPSearch
import CEPiOS

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

func makeCEPDetailsViewDataFixture(cepText: String = "CEP: 12345-678",
                                   addressText: String = "Address: Example Street, Apt 101",
                                   districtText: String = "District: Example District",
                                   cityStateText: String = "City/State: Example City, EX"
) -> CEPDetailsViewData {
    return CEPDetailsViewData(cepText: cepText,
                              addressText: addressText,
                              districtText: districtText,
                              cityStateText: cityStateText)
}
