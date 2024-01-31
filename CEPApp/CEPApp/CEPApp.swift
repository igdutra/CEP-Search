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
//    func navigateToDetails(_ details: CEPDetails) -> AnyView {
    static func navigateToDetails() -> AnyView {
//        let controller = CEPDetailsUIComposer.detailsComposed(with: details)
        let swiftUIView = CEPDetailsView()
        return AnyView(swiftUIView)
    }
}

struct CEPDetailsViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CEPDetailsViewController
    
    func makeUIViewController(context: Context) -> CEPDetailsViewController {
        return CEPDetailsViewController(viewModel: CEPDetailsViewModel(model: CEPDetails(cep: "",
                                                                                         street: "",
                                                                                         complement: "",
                                                                                         district: "",
                                                                                         city: "",
                                                                                         state: "")))
    }
    
    func updateUIViewController(_ uiViewController: CEPDetailsViewController, context: Context) {
    }
}

struct CEPDetailsView: View {
    var body: some View {
        let wrappedViewController = CEPDetailsViewRepresentable()
        
        return AnyView(wrappedViewController)
    }
}
