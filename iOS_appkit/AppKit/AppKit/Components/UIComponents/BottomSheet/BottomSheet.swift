//
//  BottomSheet.swift
//  AppKit
//
//  Created by Jyoti Luhana on 30/08/22.
//

import UIKit

class BottomSheet: UIViewController {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var transparentView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect.init(style: UIBlurEffect.Style.extraLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAppearance(ViewAppearance.init(backgroundColor: .white, cornerRadius: 28, shadowRadius: 4, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: 4), shadowColor: UIColor.blue.cgColor))
        return view
    }()
    
    lazy var containerStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 0
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var grabberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    
    var okAction:((_ selectedIndex: Int?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupView() {
        self.view.addSubview(transparentView)
        self.view.addSubview(containerView)
        
        self.view.backgroundColor = .white.withAlphaComponent(0)
        
        self.containerView.addSubview(containerStack)
        
        containerStack.addArrangedSubview(headerView)
        containerStack.addArrangedSubview(tableView)
        
        headerView.addSubview(grabberView)
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            transparentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            transparentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            transparentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            containerStack.heightAnchor.constraint(lessThanOrEqualTo: self.containerView.heightAnchor, multiplier: 0.9),
            containerStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerStack.trailingAnchor),
            tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            headerView.heightAnchor.constraint(equalToConstant: 24),
            
            grabberView.heightAnchor.constraint(equalToConstant: 3),
            grabberView.widthAnchor.constraint(equalToConstant: 24),
            grabberView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            grabberView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
}

extension BottomSheet: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Option \(indexPath.row + 1)"
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.okAction?(indexPath.row + 1)
        self.dismiss(animated: true)
    }
}
