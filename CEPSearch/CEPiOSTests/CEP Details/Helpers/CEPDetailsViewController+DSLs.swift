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
        cepTitleLabel.text
    }
    
    func addressText() -> String? {
        addressView.infoLabel.text
    }
    
    func districtText() -> String? {
        districtView.infoLabel.text
    }
    
    func cityStateText() -> String? {
        cityStateView.infoLabel.text
    }
}
