//
//  SideMenuItemCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 15/09/22.
//

import UIKit

class SideMenuItemCell: UITableViewCell {
    
    lazy var containerStackView: UIStackView = .init()
    lazy var containerView: UIView = .init()
    
    lazy var itemImage: UIImageView = .init()
    
    lazy var itemTitleLabel: UILabel = .init()
    
    lazy var itemDetailsLabel: UILabel = .init()
    
    var selectedData = (icon: "house.fill", title: "Label 1", detailsLabel: "100+")

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.containerView.backgroundColor = .white
        
        self.setupViews()
        self.addConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        containerView.layer.cornerRadius = self.frame.height / 2
    }
    
    func setupUI() {
        
        containerView.setAppearance(ViewAppearance.init(backgroundColor: isSelected ? .blue : .white,
                                                        cornerRadius: 16))
        
        containerStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                  spacing: 8,
                                                                  viewAppearance: ViewAppearance.init(
                                                                    backgroundColor: isSelected ? .blue : .white)))
        
        itemImage.setAppearance(UIImageViewAppearance.init(image: UIImage(systemName: selectedData.icon),
                                                           tintColor: isSelected ? .white : .black,
                                                           imageRenderingMode: .alwaysTemplate,
                                                           viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        itemImage.contentMode = .scaleAspectFit
        
        itemTitleLabel.setAppearance(LabelAppearance.init(text: selectedData.title,
                                                          textColor: isSelected ? .white : .black,
                                                          font: UIFont.systemFont(ofSize: 14),
                                                          viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        itemDetailsLabel.setAppearance(LabelAppearance.init(text: selectedData.detailsLabel,
                                                            textColor: isSelected ? .white : .black,
                                                            textAlignment: .right,
                                                            font: UIFont.systemFont(ofSize: 14),
                                                            viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
    }
    
    func setupViews() {
        addSubview(containerView)
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(itemImage)
        containerStackView.addArrangedSubview(itemTitleLabel)
        containerStackView.addArrangedSubview(itemDetailsLabel)
        
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
     
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            itemImage.widthAnchor.constraint(equalToConstant: 18),
            itemImage.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            itemDetailsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            itemDetailsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
        ])
    }
}
