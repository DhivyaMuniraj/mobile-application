//
//  CustomNavigationBar.swift
//  AppKit
//
//  Created by Jyoti Luhana on 30/08/22.
//

import UIKit

class CustomNavigationBar: UIView {
    
    lazy var mainStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 16
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var containerStack: UIStackView = {
        let stackview = UIStackView()
        stackview.distribution = .equalSpacing
        stackview.spacing = 16
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addImage(image: UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysTemplate), offset: 8, alignment: .left)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Product"
        return label
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addImage(image: UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysTemplate), offset: 8, alignment: .right)
        return button
    }()
    
    var titlePosition: NavBarTitlePosition = .center

    init(titlePosition: NavBarTitlePosition) {
        super.init(frame: .zero)
        self.titlePosition = titlePosition
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.setAppearance(ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255, green: 247/255, blue: 254/255, alpha: 1),shadowRadius: 2, shadowOpacity: 0.5, shadowOffset: CGSize(width: 0, height: 2), shadowColor: UIColor.gray.cgColor))
        
        self.addSubview(mainStack)
        
        self.mainStack.addArrangedSubview(containerStack)
        
        self.containerStack.addArrangedSubview(leftButton)
        
        if titlePosition == .center {
            self.containerStack.addArrangedSubview(titleLabel)
        } else {
            self.mainStack.addArrangedSubview(titleLabel)
        }
        
        self.containerStack.addArrangedSubview(rightButton)
        
        
        mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }

}

public enum NavBarTitlePosition {
    case center
    case bottom
}

public struct CustomNavBarAppearance {
    
    public init(title: String = "",
                textColor: UIColor = .black,
                textAlignment: NSTextAlignment = .left,
                leftIcon: UIImage? = UIImage(),
                rightIcon: UIImage? = UIImage(),
                titlePosition: NavBarTitlePosition = .center,
                leftIconColor: UIColor = .black,
                rightIconColor: UIColor = .black) {
        self.title = title
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.titlePosition = titlePosition
        self.leftIconColor = leftIconColor
        self.rightIconColor = rightIconColor
    }
    
    var title: String = ""
    var textColor: UIColor = .black
    var textAlignment: NSTextAlignment = .left
    var leftIcon: UIImage? = UIImage()
    var rightIcon: UIImage? = UIImage()
    var titlePosition: NavBarTitlePosition = .center
    var leftIconColor: UIColor = .black
    var rightIconColor: UIColor = .black
}

extension CustomNavigationBar {
    
    func setAppearance(_ appearance: CustomNavBarAppearance) {
        self.titleLabel.text = appearance.title
        self.titleLabel.textColor = appearance.textColor
        self.titleLabel.textAlignment = appearance.textAlignment
        self.leftButton.setImage(appearance.leftIcon, for: .normal)
        self.rightButton.setImage(appearance.rightIcon, for: .normal)
        self.leftButton.tintColor = appearance.leftIconColor
        self.rightButton.tintColor = appearance.rightIconColor
        self.titlePosition = appearance.titlePosition
    }
}
