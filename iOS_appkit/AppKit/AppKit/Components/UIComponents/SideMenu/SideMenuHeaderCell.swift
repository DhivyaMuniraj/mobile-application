//
//  SideMenuHeaderCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 15/09/22.
//

import UIKit

class SideMenuHeaderCell: UITableViewHeaderFooterView {
    
    lazy var headerLabel: UILabel = .init()

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
        
        self.backgroundColor = .green
        
        headerLabel.setAppearance(LabelAppearance.init(text: "Section Header",
                                                       textColor: .gray,
                                                       font: UIFont.boldSystemFont(ofSize: 16),
                                                       viewAppearance: ViewAppearance.init(backgroundColor: .white)))
    }
    
    func setupViews() {
        self.addSubview(headerLabel)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
        ])
    }
}
