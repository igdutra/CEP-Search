//
//  CEPDetailsViewModelTests.swift
//  CEPSearchTests
//
//  Created by Ivo on 31/01/24.
//

import XCTest
import CEPSearch

final class CEPDetailsViewModelTests: XCTestCase {

    func test_map_producesExpectedViewData() {
        let input = CEPDetails(cep: "12345-123",
                               street: "Rua",
                               complement: "Apt",
                               district: "Bairro",
                               city: "Campinas",
                               state: "SP")
        let expectedOutput = CEPDetailsViewData(cepText: "12345-123",
                                                addressTexts: InfoStrings(title: "Address",
                                                                          info: "Rua, Apt"),
                                                districtTexts: InfoStrings(title: "District",
                                                                           info: "Bairro"),
                                                cityStateTexts: InfoStrings(title: "City/State",
                                                                            info: "Campinas, SP"))
       
        XCTAssertEqual(CEPDetailsViewModel.map(input), expectedOutput)
    }
}
