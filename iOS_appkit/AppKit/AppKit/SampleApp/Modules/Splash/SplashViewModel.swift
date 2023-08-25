//
//  SplashViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//

import Foundation

protocol SplashCoordinatorDelegate: NSObject  {
    func splashDidEnd()
}

class SplashViewModel {
    weak var delegate: SplashCoordinatorDelegate?
    
    init(delegate: SplashCoordinatorDelegate) {
        self.delegate = delegate
    }
    
    func next() {
        delegate?.splashDidEnd()
    }
    
}
