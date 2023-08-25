//
//  SplashVC.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import UIKit

class SplashViewController: UIViewController {
    var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.viewModel.next()
        }
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .systemBackground
        
        
        label.textAlignment = .center
        label.textColor = .label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        label.text = "SplashViewController"
    }
    
}
