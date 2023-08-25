//
//  HeaderCollectionViewCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 07/09/22.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    lazy var recommendedLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.addConstaints()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.recommendedLabel.setAppearance(LabelAppearance.init(text: "Recommended",
                                                                 font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                                                 viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
    }
 
    func setupViews() {
        self.addSubview(recommendedLabel)
    }
    
    func addConstaints() {
        recommendedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        recommendedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        recommendedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
