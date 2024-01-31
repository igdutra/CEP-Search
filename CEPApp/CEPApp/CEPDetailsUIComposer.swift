//
//  CEPDetailsUIComposer.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

import Foundation
import CEPSearch
import CEPiOS

// Note: Exposing the public initializer through this composer, both viewModel and controllers can remain internal types
public enum CEPDetailsUIComposer {
    public static func detailsComposed(with details: CEPDetails) -> CEPDetailsViewController {
        let viewModel = CEPDetailsViewModel(model: details)
        let controller = CEPDetailsViewController(viewModel: viewModel)
        return controller
    }
}
