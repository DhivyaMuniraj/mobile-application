//
//  HomeBuilder.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

class HomeBuilder {
    var tabViews: [TabViewData]!
    var sideMenu: UIViewController!
    
    func setTabViews(tabViews: [TabViewData]) {
        self.tabViews = tabViews
    }
    
    func setSideMenu(sideMenu: UIViewController) {
        self.sideMenu = sideMenu
    }
    
    func build() -> UIViewController {
        let swContainer = SWRevealViewController()
        let frontVC = UINavigationController(rootViewController: TabBarViewController(tabViewData: tabViews))
        swContainer.frontViewController = frontVC
        swContainer.rearViewController = sideMenu
        return swContainer
    }
    
}
