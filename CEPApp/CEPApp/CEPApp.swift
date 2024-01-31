//
//  CEPAppApp.swift
//  CEPApp
//
//  Created by Ivo on 31/01/24.
//

import SwiftUI
import CEPSearch
import CEPiOS

@main
struct CEPApp: App {
    
    let searchView: CEPSearchView
    
    // MARK: - Compositon Root: Compose all componets together
    
    init() {
        let baseURL = URL(string: "https://viacep.com.br/ws/")!
        
        let session = URLSession(configuration: .default)
        let client = URLSessionHTTPClient(session: session)
        let cepGetter = RemoteCEPGetter(baseURL: baseURL, client: client)
        searchView = CEPSearchUIComposer.composeView(cepGetter: cepGetter,
                                                     nextViewToPresent: CEPApp.navigateToDetails)
    }
    
    // MARK: - View
    
    var body: some Scene {
        WindowGroup {
            searchView
        }
    }
}

// MARK: - Helpers
private extension CEPApp {
    static func navigateToDetails(_ details: CEPDetails) -> AnyView {
        let swiftUIView = CEPDetailsSwiftUIView(details: details)
        return AnyView(swiftUIView)
    }
}
