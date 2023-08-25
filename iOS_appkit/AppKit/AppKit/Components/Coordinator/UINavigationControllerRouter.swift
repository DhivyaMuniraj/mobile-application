//
//  UINavigationControllerRouter.swift
//  AppKit
//
//  Created by Jim Allan C on 22/09/22.
//

import Foundation
import UIKit

class UINavigationControllerRouter: NSObject, Router, UINavigationControllerDelegate {
    
    let navigationController = UINavigationController()
    var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    override init() {
        super.init()
        navigationController.delegate = self
    }
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismissForViewController[viewController] = onDismissed
    }
    
    func dismiss(animated: Bool) {
        navigationController.popViewController(animated: true)
    }
    
    func performOnDismissed(for
                            viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else { return }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        performOnDismissed(for: dismissedViewController)
    }
    
}

