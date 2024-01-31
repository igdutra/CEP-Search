//
//  HTTPClient.swift
//  CEPSearch
//
//  Created by Ivo on 30/01/24.
//

import Foundation

public protocol HTTPClient {
    func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse)
}
