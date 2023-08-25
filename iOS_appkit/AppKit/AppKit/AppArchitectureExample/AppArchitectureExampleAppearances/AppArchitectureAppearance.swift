//
//  AppArchitectureAppearance.swift
//  AppKit
//
//  Created by Jyoti Luhana on 26/08/22.
//

import Foundation
import UIKit



//MARK: - ButtonAppearance
struct AppArchitectureAppearance {
    
    var defaultButton: ButtonAppearance {
        return .init(textColor: .white,
                     textAlignment: .center,
                     buttonTitle: "Button",
                     contentEdgeInsets: UIEdgeInsets.init(top: 0,
                                                          left: 30,
                                                          bottom: 0,
                                                          right: 30),
                     tintColor: .white,
                     highlightedColor: .blue,
                     selectedColor: .purple,
                     disbaledColor: .systemGray4,
                     viewAppearance: ViewAppearance(backgroundColor: .blue,
                                                    cornerRadius: 20))
    }
    
    var leftIconFilledButton: ButtonAppearance {
        return .init(textColor: .white,
                     textAlignment: .center,
                     buttonTitle: "Button",
                     contentEdgeInsets: UIEdgeInsets.init(top: 0,
                                                          left: 30,
                                                          bottom: 0,
                                                          right: 30),
                     imageEdgeInsets: UIEdgeInsets.init(top: 0,
                                                        left: -10,
                                                        bottom: 0,
                                                        right: 0),
                     buttonImage: UIImage(systemName: "chevron.left"),
                     buttonPosition: .forceLeftToRight,
                     tintColor: .white,
                     highlightedColor: .blue,
                     selectedColor: .purple,
                     disbaledColor: .systemGray4,
                     viewAppearance: ViewAppearance(backgroundColor: .blue,
                                                    cornerRadius: 20))
    }
    
    var rightIconFilledButton: ButtonAppearance {
        return .init(textColor: .white,
                     textAlignment: .center,
                     buttonTitle: "Button",
                     contentEdgeInsets: UIEdgeInsets.init(top: 0,
                                                          left: 30,
                                                          bottom: 0,
                                                          right: 30),
                     imageEdgeInsets: UIEdgeInsets.init(top: 0,
                                                        left: 10,
                                                        bottom: 0,
                                                        right: -10),
                     buttonImage: UIImage(systemName: "chevron.right"),
                     buttonPosition: .forceRightToLeft,
                     tintColor: .white,
                     highlightedColor: .blue,
                     selectedColor: .purple,
                     disbaledColor: .systemGray4,
                     viewAppearance: ViewAppearance(backgroundColor: .blue,
                                                    cornerRadius: 20))
    }
    
    var outlinedButton: ButtonAppearance {
        return .init(textColor: .blue,
                     textAlignment: .center,
                     buttonTitle: "Button",
                     contentEdgeInsets: UIEdgeInsets.init(top: 0,
                                                          left: 30,
                                                          bottom: 0,
                                                          right: 30),
                     tintColor: .blue,
                     highlightedColor: .white,
                     selectedColor: .white,
                     disbaledColor: .white,
                     viewAppearance: ViewAppearance(cornerRadius: 20,
                                                    shadowRadius: 2,
                                                    shadowOpacity: 0.6,
                                                    shadowOffset: CGSize(width: 0,
                                                                         height: 2),
                                                    shadowColor: UIColor.gray.cgColor,
                                                    borderColor: UIColor.blue.cgColor,
                                                    borderWidth: 1))
    }
    
    var leftIconOutlinedButton: ButtonAppearance {
        return .init(textColor: .blue,
                     textAlignment: .center,
                     buttonTitle: "Button",
                     contentEdgeInsets: UIEdgeInsets.init(top: 0,
                                                          left: 30,
                                                          bottom: 0,
                                                          right: 30),
                     imageEdgeInsets: UIEdgeInsets.init(top: 0,
                                                        left: -10,
                                                        bottom: 0,
                                                        right: 0),
                     buttonImage: UIImage(systemName: "chevron.left"),
                     buttonPosition: .forceLeftToRight,
                     tintColor: .blue,
                     highlightedColor: .white,
                     selectedColor: .white,
                     disbaledColor: .white,
                     viewAppearance: ViewAppearance(cornerRadius: 20,
                                                    shadowRadius: 2,
                                                    shadowOpacity: 0.8,
                                                    shadowOffset: CGSize(width: 0,
                                                                         height: 2),
                                                    shadowColor: UIColor.gray.cgColor,
                                                    borderColor: UIColor.blue.cgColor,
                                                    borderWidth: 1))
    }
    
    var rightIconOutlinedButton: ButtonAppearance {
        return .init(textColor: .blue,
                     textAlignment: .center,
                     buttonTitle: "Button",
                     contentEdgeInsets: UIEdgeInsets.init(top: 0,
                                                          left: 30,
                                                          bottom: 0,
                                                          right: 30),
                     imageEdgeInsets: UIEdgeInsets.init(top: 0,
                                                        left: 10,
                                                        bottom: 0,
                                                        right: -10),
                     buttonImage: UIImage(systemName: "chevron.right"),
                     buttonPosition: .forceRightToLeft,
                     tintColor: .blue,
                     highlightedColor: .white,
                     selectedColor: .white,
                     disbaledColor: .white,
                     viewAppearance: ViewAppearance(cornerRadius: 20,
                                                    borderColor: UIColor.blue.cgColor,
                                                    borderWidth: 1))
    }
    
}

//MARK: - TextFieldAppearance
extension AppArchitectureAppearance {
    
    var defaultTextField: TextFieldAppearance {
        return .init(viewAppearance: ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255,
                                                                                  green: 247/255,
                                                                                  blue: 254/255,
                                                                                  alpha: 1) ,cornerRadius: 22))
    }
    
    var filledTextField: TextFieldAppearance {
        return .init(viewAppearance: ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255,
                                                                                  green: 247/255,
                                                                                  blue: 254/255,
                                                                                  alpha: 1) ,cornerRadius: 22,
                                                         shadowRadius: 2,
                                                         shadowOpacity: 0.6,
                                                         shadowOffset: CGSize(width: 0,
                                                                              height: 2),
                                                         shadowColor: UIColor.gray.cgColor,
                                                         borderColor: UIColor.gray.cgColor,
                                                         borderWidth: 1))
    }
    
    var typingTextField: TextFieldAppearance {
        return .init(viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.blue.cgColor,
                                                         borderWidth: 1))
    }
    
    var successTextField: TextFieldAppearance {
        return .init(viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.green.cgColor,
                                                         borderWidth: 1))
    }
    
    var errorTextField: TextFieldAppearance {
        return .init(viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.red.cgColor,
                                                         borderWidth: 1))
    }
    
    var disabledTextField: TextFieldAppearance {
        return .init(textColor: .gray,
                     isEnabled: false,viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                                          borderColor: UIColor.red.cgColor,
                                                                          borderWidth: 1))
    }
    
    var defaultLeftIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .gray,
                     viewAppearance: ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255,
                                                                                  green: 247/255,
                                                                                  blue: 254/255,
                                                                                  alpha: 1),
                                                         cornerRadius: 22))
    }
    
    var filledLeftIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .blue,
                     viewAppearance: ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255,
                                                                                  green: 247/255,
                                                                                  blue: 254/255,
                                                                                  alpha: 1),
                                                         cornerRadius: 22,
                                                         borderColor: UIColor.blue.cgColor,
                                                         borderWidth: 1))
    }
    
    var typingLeftIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .black,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.blue.cgColor,
                                                         borderWidth: 1))
    }
    
    var successLeftIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .green,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.green.cgColor,
                                                         borderWidth: 1))
    }
    
    var errorLeftIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .red,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.red.cgColor,
                                                         borderWidth: 1))
    }
    
    var disabledLeftIconTextField: TextFieldAppearance {
        return .init(textColor: .gray,
                     isEnabled: false,
                     rightImage: UIImage(systemName: "magnifyingglass"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.red.cgColor,
                                                         borderWidth: 1))
    }
    
    var outlinedRightIconTextField: TextFieldAppearance {
        return .init(rightImage: UIImage(systemName: "magnifyingglass"),
                     rightImageColor: .blue,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.blue.cgColor,
                                                         borderWidth: 1))
    }
    
    var defaultBothIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .gray,
                     rightImage: UIImage(systemName: "eye"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255,
                                                                                  green: 247/255,
                                                                                  blue: 254/255,
                                                                                  alpha: 1),
                                                         cornerRadius: 22))
    }
    
    var filledBothIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .blue,
                     rightImage: UIImage(systemName: "eye"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(backgroundColor: UIColor(displayP3Red: 244/255,
                                                                                  green: 247/255,
                                                                                  blue: 254/255,
                                                                                  alpha: 1),
                                                         cornerRadius: 22,
                                                         borderColor: UIColor.blue.cgColor,
                                                         borderWidth: 1))
    }
    
    var typingBothIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .black,
                     rightImage: UIImage(systemName: "eye"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.blue.cgColor,
                                                         borderWidth: 1))
    }
    
    var successBothIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .green,
                     rightImage: UIImage(systemName: "eye"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.green.cgColor,
                                                         borderWidth: 1))
    }
    
    var errorBothIconTextField: TextFieldAppearance {
        return .init(leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .red,
                     rightImage: UIImage(systemName: "eye"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.red.cgColor,
                                                         borderWidth: 1))
    }
    
    var disabledBothIconTextField: TextFieldAppearance {
        return .init(textColor: .gray,
                     isEnabled: false,
                     leftImage: UIImage(systemName: "magnifyingglass"),
                     leftImageColor: .red,
                     rightImage: UIImage(systemName: "eye"),
                     rightImageColor: .gray,
                     viewAppearance: ViewAppearance.init(cornerRadius: 22,
                                                         borderColor: UIColor.red.cgColor,
                                                         borderWidth: 1))
    }
    
}


//MARK: UISwitchAppearance
extension AppArchitectureAppearance {
    
    var toggleSwitchOn: UISwitchAppearance {
        return .init(onTintColor: .blue,
                     offTintColor: UIColor(displayP3Red: 244/255,
                                           green: 247/255,
                                           blue: 254/255,
                                           alpha: 1),
                     thumbnailScaleSize: (scaleX: 1,
                     scaleY: 1))
    }
    
    var toggleSwitchOff: UISwitchAppearance {
        return .init(onTintColor: .blue,
                     offTintColor: UIColor(displayP3Red: 244/255,
                                           green: 247/255,
                                           blue: 254/255,
                                           alpha: 1),
                     thumbnailScaleSize: (scaleX: 0.7,
                     scaleY: 0.7))
    }
}
