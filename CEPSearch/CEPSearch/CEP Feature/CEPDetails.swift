//
//  CEPDetails.swift
//  CEPSearch
//
//  Created by Ivo on 28/01/24.
//

import Foundation

public struct CEPDetails: Equatable {
    public let cep: String
    public let street: String
    public let complement: String
    public let district: String
    public let city: String
    public let state: String
    
    public init(cep: String, street: String, complement: String, district: String, city: String, state: String) {
        self.cep = cep
        self.street = street
        self.complement = complement
        self.district = district
        self.city = city
        self.state = state
    }
}
