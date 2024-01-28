//
//  CEPGetter.swift
//  CEPSearch
//
//  Created by Ivo on 28/01/24.
//

import Foundation

public protocol CEPGetter {
    func getCEPDetails(for cep: String) async throws -> CEPDetails
}
