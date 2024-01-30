//
//  Fixtures.swift
//  CEPiOSTests
//
//  Created by Ivo on 29/01/24.
//

import CEPiOS

func makeCEPDetailsViewDataFixture(cepText: String = "12345-678",
                                   addressText: String = "Example Street, Apt 101",
                                   districtText: String = "Example District",
                                   cityStateText: String = "Example City, EX"
) -> CEPDetailsViewData {
    return CEPDetailsViewData(cepText: cepText,
                              addressTexts: InfoStrings(title: "Address", info: addressText),
                              districtTexts:  InfoStrings(title: "District", info: districtText),
                              cityStateTexts: InfoStrings(title: "City", info: cityStateText))
}
