//
//  CustomAlert.swift
//  AppKit
//
//  Created by Jyoti Luhana on 30/08/22.
//

import UIKit

class CustomAlert: UIView {

    lazy var dimmedView: UIView = .init()
    
    lazy var mainContainerView: UIView = .init()
    
    lazy var containerStack: UIStackView = .init()
    
    lazy var alertIcon: UIButton = .init()
    
    lazy var titleLabel: UILabel = .init()
    
    lazy var descriptionLabel: UILabel = .init()
    
    lazy var actionButtonStack: UIStackView = .init()
    
    lazy var leftButton: UIButton = .init()
    
    lazy var rightButton: UIButton = .init()
    
    init(isIconAlert: Bool = false)  {
        super.init(frame: .zero)
        
        self.alertIcon.isHidden = !isIconAlert
        self.setupView()
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.dimmedView.setAppearance(ViewAppearance.init(backgroundColor: .white.withAlphaComponent(0)))
        
        self.mainContainerView.setAppearance(ViewAppearance.init(
                                                backgroundColor: .white,
                                                cornerRadius: 28,
                                                shadowRadius: 4,
                                                shadowOpacity: 0.3,
                                                shadowOffset: CGSize(width: 0, height: 4),
                                                shadowColor: UIColor.blue.cgColor))
        
        self.containerStack.setAppearance(StackViewAppearance.init(spacing: 24,
                                                                   distribution: .fillProportionally,
                                                                   viewAppearance: ViewAppearance.init(backgroundColor: .white)))
        
        self.alertIcon.setAppearance(ButtonAppearance.init(buttonImage: UIImage(systemName: "person.circle"),
                                                           viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        self.titleLabel.setAppearance(LabelAppearance.init(text: "Alert",
                                                           textAlignment: .center,
                                                           viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        self.descriptionLabel.setAppearance(LabelAppearance.init(text: """
                        A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.
                        """,
                                                                 textAlignment: .center,
                                                                 numberOfLines: 0,
                                                                 viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        self.actionButtonStack.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                      alignment: .trailing,
                                                                      spacing: 8,
                                                                      distribution: .fillProportionally,
                                                                      viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        self.leftButton.setAppearance(ButtonAppearance.init(textColor: .blue,
                                                            buttonTitle: "Action 2",
                                                            viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        self.rightButton.setAppearance(ButtonAppearance.init(textColor: .white,
                                                             buttonTitle: "Action 1",
                                                             contentEdgeInsets: UIEdgeInsets.init(top: 8, left: 12, bottom: 8, right: 12),
                                                             viewAppearance: ViewAppearance.init(backgroundColor: .blue, cornerRadius: 15)))
        
    }
    
    private func setupView() {
        
        self.addSubview(dimmedView)
        
        self.dimmedView.addSubview(mainContainerView)
        
        self.mainContainerView.addSubview(containerStack)
        
        self.containerStack.addArrangedSubview(alertIcon)
        self.containerStack.addArrangedSubview(titleLabel)
        self.containerStack.addArrangedSubview(descriptionLabel)
        self.containerStack.addArrangedSubview(actionButtonStack)
        
        self.actionButtonStack.addArrangedSubview(leftButton)
        self.actionButtonStack.addArrangedSubview(rightButton)
        
        NSLayoutConstraint.activate([
            dimmedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dimmedView.topAnchor.constraint(equalTo: self.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mainContainerView.leadingAnchor.constraint(equalTo: self.dimmedView.leadingAnchor, constant: 12),
            mainContainerView.trailingAnchor.constraint(equalTo: self.dimmedView.trailingAnchor, constant: -12),
            mainContainerView.topAnchor.constraint(equalTo: self.dimmedView.topAnchor, constant: 12),
            mainContainerView.bottomAnchor.constraint(equalTo: self.dimmedView.bottomAnchor, constant: -12),
            
            containerStack.leadingAnchor.constraint(equalTo: self.mainContainerView.leadingAnchor, constant: 24),
            containerStack.trailingAnchor.constraint(equalTo: self.mainContainerView.trailingAnchor, constant: -24),
            containerStack.topAnchor.constraint(equalTo: self.mainContainerView.topAnchor,constant: 24),
            containerStack.bottomAnchor.constraint(equalTo: self.mainContainerView.bottomAnchor, constant: -24),
            
            leftButton.heightAnchor.constraint(equalToConstant: 30),
            rightButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}

public struct CustomAlertAppearance {
    
    public init(title: String = "",
                textColor: UIColor = .black,
                textAlignment: NSTextAlignment = .center,
                description: String = "",
                descriptionColor: UIColor = .black,
                descriptionAlignment: NSTextAlignment = .center,
                leftButtonTitle: String = "",
                rightButtonTitle: String = "") {
        self.title = title
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.description = description
        self.descriptionColor = descriptionColor
        self.descriptionAlignment = descriptionAlignment
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
    }
    
    var title: String = ""
    var textColor: UIColor = .black
    var textAlignment: NSTextAlignment = .center
    var description: String = ""
    var descriptionColor: UIColor = .black
    var descriptionAlignment: NSTextAlignment = .center
    var leftButtonTitle: String = ""
    var rightButtonTitle: String = ""
}

extension CustomAlert {
    
    func setAppearance(_ appearance: CustomAlertAppearance) {
        self.titleLabel.text = appearance.title
        self.titleLabel.textColor = appearance.textColor
        self.titleLabel.textAlignment = appearance.textAlignment
        self.descriptionLabel.text = appearance.description
        self.descriptionLabel.textColor = appearance.descriptionColor
        self.descriptionLabel.textAlignment = appearance.descriptionAlignment
        self.leftButton.setTitle(appearance.leftButtonTitle, for: .normal)
        self.rightButton.setTitle(appearance.rightButtonTitle, for: .normal)
    }
}
