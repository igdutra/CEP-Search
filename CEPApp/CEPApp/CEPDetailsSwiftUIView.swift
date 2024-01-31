//
//  CEPDetailsSwiftUIView.swift
//  CEPApp
//
//  Created by Ivo on 31/01/24.
//

import SwiftUI
import CEPSearch
import CEPiOS

struct CEPDetailsViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CEPDetailsViewController
    
    let details: CEPDetails
    
    func makeUIViewController(context: Context) -> CEPDetailsViewController {
        let controller = CEPDetailsUIComposer.detailsComposed(with: details)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CEPDetailsViewController, context: Context) { }
}

struct CEPDetailsSwiftUIView: View {
    
    let details: CEPDetails
    
    var body: some View {
        let wrappedViewController = CEPDetailsViewRepresentable(details: details)
        return wrappedViewController
    }
}
