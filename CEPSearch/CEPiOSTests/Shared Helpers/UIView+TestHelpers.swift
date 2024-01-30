//
//  UIView+TestHelpers.swift
//  CEPiOSTests
//
//  Created by Ivo on 30/01/24.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
