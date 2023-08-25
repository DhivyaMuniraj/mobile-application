//
//  SideMenuFooterCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 15/09/22.
//

import UIKit

class SideMenuFooterCell: UITableViewHeaderFooterView {
    
    lazy var seperatorView: UIView = .init()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
        self.addConstraints()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        seperatorView.setAppearance(ViewAppearance.init(backgroundColor: .gray))
        
    }
    
    func setupViews() {
        self.addSubview(seperatorView)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            seperatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
    }
}
