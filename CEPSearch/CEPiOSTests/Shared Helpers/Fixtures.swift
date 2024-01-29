//
//  Fixtures.swift
//  CEPiOSTests
//
//  Created by Ivo on 29/01/24.
//

import CEPiOS

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
