//
//  SearchViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

protocol SearchViewCoordinatorrDelegate: NSObject {
    
}

class SearchViewViewModel {
    weak var delegate: SearchViewCoordinatorrDelegate?
    
    init(delegate: SearchViewCoordinatorrDelegate) {
        self.delegate = delegate
    }
    
}
