//
//  SettingsViewController.swift
//  AppKit
//
//  Created by Jyoti Luhana on 15/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewCoordinatorrDelegate
    
    init(viewModel: SettingsViewCoordinatorrDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .yellow
    }
    
}
