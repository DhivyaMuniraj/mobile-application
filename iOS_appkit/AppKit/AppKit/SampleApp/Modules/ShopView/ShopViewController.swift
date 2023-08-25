//
//  ShopViewController.swift
//  AppKit
//
//  Created by Jyoti Luhana on 15/09/22.
//

import UIKit

class ShopViewController: UIViewController {
    
    var viewModel: ShopViewCoordinatorrDelegate
    
    init(viewModel: ShopViewCoordinatorrDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
    }
    
}
