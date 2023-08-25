//
//  LoginCoordinator.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//

import Foundation

class LoginCoordinator: NSObject, Coordinator {
    
    // MARK: - Instance Properties
    var children: [Coordinator] = []
    let router: Router
    lazy var viewController: UIViewController = {
        let service: AnyLoginService! = ServiceLocator.shared.getService()
        let viewModel = LoginViewModel(delegate: self, loginService: service)
        return LoginViewController(viewModel: viewModel)
    }()
    
    // MARK: - Object Lifecycle
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Instance Methods
    func start(onDismissed: (() -> Void)?) {
        router.present(viewController, animated: true, onDismissed: onDismissed)
    }
    
}
extension LoginCoordinator: LoginCoordinatorrDelegate {
    
    func loginDidComplete(user: User) {
        let router = HomeRouter(parentViewController: viewController)
        let coordinator = HomeCoordinator(router: router, user: user)
        presentChild(coordinator, animated: true)
    }
    
    func startSignup() {
        
    }
    
    func startForgotPassword() {
        let controller = ForgotPasswordViewController(viewModel: .init(delegate: self))
        self.router.present(controller, animated: true)
    }
    
}
extension LoginCoordinator: ForgotPasswordCoordinatorDelegate {
    
    func forgotPasswordDidComplete() {
        self.router.dismiss(animated: true)
    }
    
}
