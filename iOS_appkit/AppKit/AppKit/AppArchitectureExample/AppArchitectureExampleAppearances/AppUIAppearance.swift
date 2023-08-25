//
//  AppUIAppearance.swift
//  AppKit
//
//  Created by Jyoti Luhana on 29/08/22.
//

import Foundation
import UIKit

//MARK: - CheckboxAppearance
public struct CheckboxAppearance {
    
    public init(textColor: UIColor = .black,
                textAlignment: NSTextAlignment = .left,
                contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30),
                imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0),
                buttonImage: UIImage? = UIImage(systemName: "chevron.right"),
                buttonPosition: UISemanticContentAttribute = .forceRightToLeft,
                tintColor: UIColor = .systemBlue,
                font: UIFont = UIFont.preferredFont(forTextStyle: .body),
                isEnabled: Bool = false,
                viewAppearance: ViewAppearance = ViewAppearance()) {
        
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.textAlignment = textAlignment
        self.contentEdgeInsets = contentEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        self.buttonImage = buttonImage
        self.buttonPosition = buttonPosition
        self.tintColor = tintColor
        self.font = font
        self.isEnabled = isEnabled
        self.viewAppearance = viewAppearance
    }
    
    var textColor: UIColor = .black
    var textAlignment: NSTextAlignment = .left
    var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 30)
    var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
    var buttonImage: UIImage? = UIImage(systemName: "checkmark.circle.fill")
    var buttonPosition: UISemanticContentAttribute = .forceRightToLeft
    var tintColor: UIColor = .systemBlue
    var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
    var isEnabled: Bool = false
    var buttonAppearance: ButtonAppearance = ButtonAppearance()
    var viewAppearance: ViewAppearance = ViewAppearance()
}

public extension UIButton {
    
    enum ImageAlignment {
        case left
        case right
    }
    
    func setAppearance(_ appearance: CheckboxAppearance) {
        self.setTitleColor(appearance.textColor, for: .normal)
        self.titleLabel?.textAlignment = appearance.textAlignment

        self.tintColor = appearance.tintColor
        self.titleLabel?.font = appearance.font
        
        self.contentHorizontalAlignment = .left
        
        self.addImage(image: appearance.buttonImage, offset: 20, alignment: .right)

        self.setAppearance(appearance.viewAppearance)
    }
    
    func addImage(image: UIImage?, offset: CGFloat, alignment: ImageAlignment) {
        self.setImage(image, for: .normal)
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        if alignment == ImageAlignment.right {
            self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
        } else {
            self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.imageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset).isActive = true
        }
    }
}
