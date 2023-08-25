//
//  HomeFactory.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

class HomeTabViewsFactory {
    let delegate: HomeCoordinator
    
    init(delegate: HomeCoordinator) {
        self.delegate = delegate
    }
    
    func createTabsFor(user: User) -> [TabViewData] {
        return [
            TabViewData(icon: "home", title: "Home", viewController: DashboardViewController(viewModel: .init(delegate: delegate))),
            TabViewData(icon: "search", title: "Search", viewController: SearchViewController(viewModel: delegate)),
            TabViewData(icon: "shop", title: "Shop", viewController: ShopViewController(viewModel: delegate)),
            TabViewData(icon: "settings", title: "Settings", viewController: SettingsViewController(viewModel: delegate))
        ]
    }
    
}
