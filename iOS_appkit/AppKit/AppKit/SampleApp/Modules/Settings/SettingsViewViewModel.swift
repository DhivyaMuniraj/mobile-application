//
//  SettingsViewViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

protocol SettingsViewCoordinatorrDelegate: NSObject {
    
}

class SettingsViewViewModel {
    weak var delegate: SettingsViewCoordinatorrDelegate?
    
    init(delegate: SettingsViewCoordinatorrDelegate) {
        self.delegate = delegate
    }
    
}
