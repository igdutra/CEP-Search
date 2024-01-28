//
//  CEPGetterSpy.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import CEPSearch

final class CEPGetterSpy: CEPGetter {
    enum ReceivedMessage: Equatable {
        case getDetails(String)
    }
    private(set) var receivedMessages = [ReceivedMessage]()
    
    // MARK: - Interface

    func getCEPDetails(for cep: String) async throws -> CEPDetails {
        receivedMessages.append(.getDetails(cep))
        
        return CEPDetails(cep: .init(),
                          street: .init(),
                          complement: .init(),
                          district: .init(),
                          city: .init(),
                          state: .init())
    }
}
