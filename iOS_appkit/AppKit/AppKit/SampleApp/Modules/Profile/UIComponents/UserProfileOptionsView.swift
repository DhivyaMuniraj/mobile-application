//
//  UserProfileOptionsView.swift
//  AppKit
//
//  Created by Jyoti Luhana on 08/09/22.
//

import UIKit

class UserProfileOptionsView: UIView {
    
    lazy var containerStackView: UIStackView = .init()
    
    lazy var optionLeftIconImageView: UIImageView = .init()
    lazy var optionTitleLabel: UILabel = .init()
    lazy var optionRightIconImageView: UIImageView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.addConstraints()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        
        containerStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                  spacing: 8, distribution: .fill, viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        optionLeftIconImageView.setAppearance(UIImageViewAppearance.init(image: UIImage(named: "order_icon"),
                                                                         viewAppearance: ViewAppearance.init(backgroundColor: .clear,
                                                                                                             cornerRadius: 15)))
        
        optionTitleLabel.setAppearance(LabelAppearance.init(text: "Option",
                                                            textAlignment: .center,
                                                            font: UIFont.systemFont(ofSize: 12),
                                                            viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        optionRightIconImageView.setAppearance(UIImageViewAppearance.init(image: UIImage(named: "chevron_right"),
                                                                          viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        optionRightIconImageView.contentMode = .scaleAspectFit
    }
    
    func setupViews() {
        
        self.addSubview(containerStackView)
        
        self.containerStackView.addArrangedSubview(optionLeftIconImageView)
        self.containerStackView.addArrangedSubview(optionTitleLabel)
        self.containerStackView.addArrangedSubview(optionRightIconImageView)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            optionLeftIconImageView.widthAnchor.constraint(equalToConstant: 30),
            optionLeftIconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}


struct UserProfileOptionViewAppearance {
    
    public init(leftIcon: UIImage? = nil,
                title: String = "",
                rightIcon: UIImage? = UIImage(named: "chevron_right"),
                viewAppearance: ViewAppearance = ViewAppearance.init(backgroundColor: .white,
                                                                     cornerRadius: 10,
                                                                     shadowRadius: 4,
                                                                     shadowOpacity: 0.25,
                                                                     shadowOffset: CGSize(width: 2, height: 2),
                                                                     shadowColor: UIColor.init(red: 67/255, green: 24/255, blue: 255/255, alpha: 1).cgColor)) {
        
        self.leftIcon = leftIcon
        self.title = title
        self.rightIcon = rightIcon
        self.viewAppearance = viewAppearance
        
    }
    
    var leftIcon: UIImage? = nil
    var title: String = ""
    var rightIcon: UIImage? = UIImage(named: "chevron_right")
    var viewAppearance: ViewAppearance = ViewAppearance.init(backgroundColor: .white,
                                                             cornerRadius: 10,
                                                             shadowRadius: 4,
                                                             shadowOpacity: 0.25,
                                                             shadowOffset: CGSize(width: 2, height: 2),
                                                             shadowColor: UIColor.init(red: 67/255, green: 24/255, blue: 255/255, alpha: 1).cgColor)
}

extension UserProfileOptionsView {
    
    func setAppearance(_ appearance: UserProfileOptionViewAppearance) {
        self.optionRightIconImageView.image = appearance.rightIcon
        self.optionLeftIconImageView.image = appearance.leftIcon
        self.optionTitleLabel.text = appearance.title
        
        self.setAppearance(appearance.viewAppearance)
    }
}
