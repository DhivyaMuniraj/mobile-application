//
//  DashboardViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 22/09/22.
//

import Foundation

protocol DashboardCoordinatorrDelegate: NSObject {
    
}

class DashboardViewModel {
    weak var delegate: DashboardCoordinatorrDelegate?
    
    init(delegate: DashboardCoordinatorrDelegate) {
        self.delegate = delegate
    }
    
}
