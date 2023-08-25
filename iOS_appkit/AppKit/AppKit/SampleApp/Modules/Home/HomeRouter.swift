//
//  HomeRouter.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation
import UIKit

class HomeRouter: UINavigationControllerRouter {
    // MARK: - Instance Properties
    unowned let parentViewController: UIViewController
    
    // MARK: - Object Lifecycle
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()
    }
    
    override func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        super.present(viewController, animated: animated, onDismissed: onDismissed)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([viewController], animated: false)
        parentViewController.present(navigationController, animated: true)
    }
    
    override func dismiss(animated: Bool) {
        performOnDismissed(for: navigationController.viewControllers.first!)
        parentViewController.dismiss(animated: true)
    }
    
}
