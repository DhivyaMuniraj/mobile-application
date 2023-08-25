//
//  RecommendedCollectionViewCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 06/09/22.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    
    lazy var mainContainerView: UIView = .init()
    
    lazy var containerStackView: UIStackView = .init()
    
    lazy var productImageView: UIImageView = .init()
    
    lazy var productNameLabel: UILabel = .init()
    
    lazy var productPriceLabel: UILabel = .init()
    
    lazy var favoriteButton: UIButton = .init()
    
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
        
        self.containerStackView.setAppearance(StackViewAppearance.init(axis: .vertical,
                                                                       alignment: .fill,
                                                                       spacing: 10,
                                                                       distribution: .fillProportionally,
                                                                       viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        self.productImageView.setAppearance(UIImageViewAppearance.init(image: UIImage(named: "product_image"),
                                                                       viewAppearance: ViewAppearance(backgroundColor: .gray,
                                                                                                      cornerRadius: 16,
                                                                                        translatesAutoresizingMaskIntoConstraints: false)))
        self.productImageView.clipsToBounds = true
        
        self.productNameLabel.setAppearance(LabelAppearance.init(text: "Olive Zip-Front Jacket",
                                                                 font: UIFont.systemFont(ofSize: 12),
                                                                 viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        self.productPriceLabel.setAppearance(LabelAppearance.init(text: "Rs. 3,499",
                                                                  textColor: .gray,
                                                                  font: UIFont.systemFont(ofSize: 14),
                                                                  viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))

        self.favoriteButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "favorite_selected"),
                                                                viewAppearance: ViewAppearance.init(
                                                                    backgroundColor: .white.withAlphaComponent(0.5),
                                                                    cornerRadius: 12,
                                                                    translatesAutoresizingMaskIntoConstraints: false)))
        
    }
    
    func setupViews() {
        
        self.addSubview(containerStackView)
        
        self.containerStackView.addArrangedSubview(productImageView)
        self.containerStackView.addArrangedSubview(productNameLabel)
        self.containerStackView.addArrangedSubview(productPriceLabel)
        
//        self.productImageView.addSubview(favoriteButton)
    }
    
    func addConstaints() {
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: (self.frame.width) * 1.10 )
        ])

//        NSLayoutConstraint.activate([
//            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
//            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
//            favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 12),
//            favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -12)
//        ])
    }
 
}
