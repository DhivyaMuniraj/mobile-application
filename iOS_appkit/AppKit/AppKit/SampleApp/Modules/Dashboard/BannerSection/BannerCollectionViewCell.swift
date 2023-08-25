//
//  BannerCollectionViewCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 06/09/22.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    lazy var mainContainerView: UIView = .init()
    
    lazy var imageContainerView: UIImageView = .init()
    
    lazy var cardContainerView: UIView = .init()
    
    lazy var detailsContainerMainStackView: UIStackView = .init()
    
    lazy var headerTitleLabel: UILabel = .init()
    
    lazy var footerTitleLabel: UILabel = .init()
    
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
        
        mainContainerView.setAppearance(ViewAppearance.init(backgroundColor: .clear,
                                                            translatesAutoresizingMaskIntoConstraints: false))
        
        imageContainerView.setAppearance(UIImageViewAppearance.init(image: UIImage(named: "bannerImage"),
                                                                    viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        cardContainerView.setAppearance(ViewAppearance.init(backgroundColor: .blue,
                                                            cornerRadius: 16,
                                                            shadowRadius: 4,
                                                            shadowOpacity: 0.8,
                                                            shadowOffset: CGSize(width: 0, height: 4),
                                                            shadowColor: UIColor.gray.cgColor,
                                                            translatesAutoresizingMaskIntoConstraints: false))
        
        detailsContainerMainStackView.setAppearance(StackViewAppearance.init(spacing: 10,
                                                                             distribution: .fillProportionally,
                                                                             viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        headerTitleLabel.setAppearance(LabelAppearance.init(textColor: .white,
                                                            numberOfLines: 2,
                                                            font: UIFont.boldSystemFont(ofSize: 20),
                                                            viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        let attrString = NSMutableAttributedString(string: "End of Season \n",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        attrString.append(NSMutableAttributedString(string: "Sale",
                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]))
        
        headerTitleLabel.attributedText = attrString
        
        footerTitleLabel.setAppearance(LabelAppearance.init(textColor: .white,
                                                            numberOfLines: 2,
                                                            font: UIFont.boldSystemFont(ofSize: 20),
                                                            viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        let footerAttrString = NSMutableAttributedString(string: "Upto \n",
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        footerAttrString.append(NSMutableAttributedString(string: "60",
                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]))
        footerAttrString.append(NSMutableAttributedString(string: "% OFF",
                                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        
        footerTitleLabel.attributedText = footerAttrString
    }
    
    func setupViews() {
        self.addSubview(mainContainerView)
        
        self.mainContainerView.addSubview(cardContainerView)
        self.mainContainerView.addSubview(imageContainerView)
        
        self.cardContainerView.addSubview(detailsContainerMainStackView)
        
        detailsContainerMainStackView.addArrangedSubview(headerTitleLabel)
        detailsContainerMainStackView.addArrangedSubview(footerTitleLabel)
    }
    
    func addConstaints() {
        NSLayoutConstraint.activate([
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            imageContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            imageContainerView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            imageContainerView.widthAnchor.constraint(equalTo: mainContainerView.widthAnchor, multiplier: 0.55)
        ])
        
        NSLayoutConstraint.activate([
            cardContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            cardContainerView.widthAnchor.constraint(equalTo: mainContainerView.widthAnchor),
            cardContainerView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            detailsContainerMainStackView.topAnchor.constraint(equalTo: cardContainerView.topAnchor, constant: 20),
            detailsContainerMainStackView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 16),
            detailsContainerMainStackView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -20),
            detailsContainerMainStackView.widthAnchor.constraint(equalTo: cardContainerView.widthAnchor, multiplier: 0.45)
        ])
    }
}
