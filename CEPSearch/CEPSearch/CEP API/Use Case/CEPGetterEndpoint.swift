//
//  CEPGetterEndpoint.swift
//  CEPSearch
//
//  Created by Ivo on 31/01/24.
//

import Foundation

public enum CEPGetterEndpoint {
    case get(String)
    
    // Base URL is https://viacep.com.br/ws/
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(cep):
            return baseURL.appendingPathComponent("/\(cep)/json")
        }
    }
}
