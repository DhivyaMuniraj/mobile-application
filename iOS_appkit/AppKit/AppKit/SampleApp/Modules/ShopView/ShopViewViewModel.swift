//
//  ShopViewViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

protocol ShopViewCoordinatorrDelegate: NSObject {
    
}

class ShopViewViewModel {
    weak var delegate: ShopViewCoordinatorrDelegate?
    
    init(delegate: ShopViewCoordinatorrDelegate) {
        self.delegate = delegate
    }
    
}
