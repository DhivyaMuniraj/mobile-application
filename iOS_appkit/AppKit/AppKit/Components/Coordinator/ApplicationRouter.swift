//
//  ApplicationRouter.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//

import UIKit

class ApplicationRouter: Router {
    // MARK: - Instance Properties
    let window: UIWindow
    
    // MARK: - Object Lifecycle
    init(window: UIWindow) {
        self.window = window
    }
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (()->Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func dismiss(animated: Bool) {
        // don't do anything
    }
    
}
