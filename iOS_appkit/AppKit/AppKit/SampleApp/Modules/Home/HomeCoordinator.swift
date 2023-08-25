//
//  HomeCoordinator.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

class HomeCoordinator: NSObject, Coordinator {
    
    // MARK: - Instance Properties
    var children: [Coordinator] = []
    let user: User
    let router: Router
    lazy var builder = HomeBuilder()
    lazy var factory = HomeTabViewsFactory(delegate: self)
    
    // MARK: - Object Lifecycle
    init(router: Router, user: User) {
        self.router = router
        self.user = user
    }
    
    // MARK: - Instance Methods
    func start(onDismissed: (() -> Void)?) {
        let userTabs = factory.createTabsFor(user: user)
        builder.setTabViews(tabViews: userTabs)
        builder.setSideMenu(sideMenu: SideMenuViewController())
        let viewController = builder.build()
        router.present(viewController, animated: true, onDismissed: onDismissed)
    }
    
}

extension HomeCoordinator: DashboardCoordinatorrDelegate {
    
}
extension HomeCoordinator: SettingsViewCoordinatorrDelegate {
    
}
extension HomeCoordinator: SearchViewCoordinatorrDelegate {
    
}
extension HomeCoordinator: ShopViewCoordinatorrDelegate {
    
}
