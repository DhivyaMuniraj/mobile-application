//
//  LoginRouter.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//

import UIKit

class LoginRouter: UINavigationControllerRouter {
    
    // MARK: - Instance Properties
    unowned let parentViewController: UIViewController
    
    // MARK: - Object Lifecycle
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()
    }
    
    override func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        super.present(viewController, animated: animated, onDismissed: onDismissed)
        if navigationController.viewControllers.count == 0 {
            presentModally(viewController, animated: animated)
        } else {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    func presentModally(
        _ viewController: UIViewController,
        animated: Bool) {
            navigationController.setViewControllers([viewController], animated: false)
            navigationController.modalPresentationStyle = .fullScreen
            parentViewController.present(navigationController, animated: animated, completion: nil)
        }
    
}
