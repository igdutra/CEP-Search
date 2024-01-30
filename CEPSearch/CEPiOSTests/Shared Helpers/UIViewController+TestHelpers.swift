//
//  UIViewController+TestHelpers.swift
//  CEPiOSTests
//
//  Created by Ivo on 30/01/24.
//

import UIKit

extension UIViewController {
    
    /* Developer Note:
     prior to iOS 17, calling loadViewIfNeeded+runLoop was enough
     
     now, with the new API viewIsAppearing, we need to enfore the rest of the cycle.
     
     A delay was added to the test, which is not ideal to relay on delays since they can be flaky.
     A discussion must be made in order to validate this approach. 
     UIIntegrationTests will be moved to the App Target. Assess then if this solved the issue.
     Not present on iOS 16.
    */
    func simulateAppearance() {
        loadViewIfNeeded()
        RunLoop.current.run(until: Date()+0.1)
        
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}
