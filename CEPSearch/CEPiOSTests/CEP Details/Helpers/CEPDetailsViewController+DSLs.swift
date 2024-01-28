//
//  CEPDetailsViewController+DSLs.swift
//  CEPSearch
//
//  Created by Ivo on 28/01/24.
//

import CEPiOS

// MARK: - DSLs - Domain Specific Language

// Note: this is to protect the tests against any UIKit implementation details

extension CEPDetailsViewController {
    func cepText() -> String? {
        cepLabel.text
    }
    
    func addressText() -> String? {
        addressLabel.text
    }
    
    func districtText() -> String? {
        districtLabel.text
    }
    
    func cityStateText() -> String? {
        cityStateLabel.text
    }
}
