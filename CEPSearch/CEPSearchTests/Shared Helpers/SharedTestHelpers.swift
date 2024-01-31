//
//  SharedTestHelpers.swift
//  CEPSearch
//
//  Created by Ivo on 30/01/24.
//

import Foundation

// MARK: - Free Funcs

func anyURL(_ host: String = "a-url.com") -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    return components.url ?? URL(string: "https://default-url.com")!
}

struct AnyError: Error, Equatable {
    let message: String
    init(message: String = .init()) {
        self.message = message
    }
}

func anyErrorErased(_ message: String = .init()) -> Error {
    return AnyError(message: message)
}
