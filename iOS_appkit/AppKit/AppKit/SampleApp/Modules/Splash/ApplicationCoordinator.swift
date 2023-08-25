//
//  ApplicationCoordinator.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//

import Foundation

class ApplicationCoordinator: NSObject, Coordinator {
    
    // MARK: - Instance Properties
    var children: [Coordinator] = []
    let router: Router
    lazy var viewController = SplashViewController(viewModel: .init(delegate: self))
    
    // MARK: - Object Lifecycle
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Instance Methods
    func start(onDismissed: (() -> Void)?) {
        router.present(viewController, animated: true, onDismissed: onDismissed)
    }
    
}
extension ApplicationCoordinator: SplashCoordinatorDelegate {
    
    func splashDidEnd() {
        let router = LoginRouter(parentViewController: viewController)
        let coordinator = LoginCoordinator(router: router)
        presentChild(coordinator, animated: true)
    }
    
}
