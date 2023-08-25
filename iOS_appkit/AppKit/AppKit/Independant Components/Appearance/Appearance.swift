//
//  Appearance.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import UIKit

/*
extension CACornerMask {
	
	public static var topLeft: CACornerMask     = .layerMinXMinYCorner // { get }
	public static var topRight: CACornerMask    = .layerMaxXMinYCorner // { get }
	public static var bottomLeft: CACornerMask  = .layerMinXMaxYCorner // { get }
	public static var bottomRight: CACornerMask = .layerMaxXMaxYCorner // { get }
}
*/

//MARK: - ViewAppearance
public struct ViewAppearance {
	
	public init(backgroundColor: UIColor = .white,
				cornerRadius: CGFloat = 0,
				maskedCorners: CACornerMask = [.topLeft,
                                               .topRight,
                                               .bottomLeft,
                                               .bottomRight],
                masksToBounds: Bool = false,
                clipsToBounds: Bool = true,
				shadowRadius: CGFloat = 0,
				shadowOpacity: Float = 0,
				shadowOffset: CGSize = .zero,
				shadowColor: CGColor = UIColor.clear.cgColor,
				borderColor: CGColor = UIColor.clear.cgColor,
				borderWidth: CGFloat = 0,
                translatesAutoresizingMaskIntoConstraints: Bool = false) {
		
		self.backgroundColor = backgroundColor
		self.cornerRadius = cornerRadius
		self.maskedCorners = maskedCorners
        self.masksToBounds = masksToBounds
        self.clipsToBounds = clipsToBounds
		self.shadowRadius = shadowRadius
		self.shadowOpacity = shadowOpacity
		self.shadowOffset = shadowOffset
		self.shadowColor = shadowColor
		self.borderColor = borderColor
		self.borderWidth = borderWidth
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
	}
	
	public var backgroundColor: UIColor
	public var cornerRadius: CGFloat
	public var maskedCorners: CACornerMask
    public var masksToBounds: Bool
    public var clipsToBounds: Bool
	public var shadowRadius: CGFloat
	public var shadowOpacity: Float
	public var shadowOffset: CGSize
	public var shadowColor: CGColor
	public var borderColor: CGColor
	public var borderWidth: CGFloat
    public var translatesAutoresizingMaskIntoConstraints: Bool
}

public extension ViewAppearance {
    
    static let clear = ViewAppearance(backgroundColor: .clear,
                                      cornerRadius: 0,
                                      maskedCorners: [],
                                      shadowRadius: 0,
                                      shadowOpacity: 0,
                                      shadowOffset: .zero,
                                      shadowColor: UIColor.clear.cgColor,
                                      borderColor: UIColor.clear.cgColor,
                                      borderWidth: 0)

    static let clearBGAllCornerShadow = ViewAppearance.init(backgroundColor: .clear,
                                                            cornerRadius: 12,
                                                            maskedCorners: [.topLeft,
                                                                            .topRight,
                                                                            .bottomLeft,
                                                                            .bottomRight],
                                                            shadowRadius: 5.0,
                                                            shadowOpacity: 0.20,
                                                            shadowOffset: .init(width: 0.0, height: 5.0),
                                                            shadowColor: UIColor.black.cgColor,
                                                            borderColor: UIColor.clear.cgColor,
                                                            borderWidth: 0.0)

    static let clearBGTopCornerShadow = ViewAppearance.init(backgroundColor: .clear,
                                                            cornerRadius: 15,
                                                            maskedCorners: [.topLeft, .topRight],
                                                            shadowRadius: 5.0,
                                                            shadowOpacity: 0.20,
                                                            shadowOffset: .init(width: 0.0, height: -5.0),
                                                            shadowColor: UIColor.black.cgColor,
                                                            borderColor: UIColor.clear.cgColor,
                                                            borderWidth: 0.0)

}

public extension UIView {
	func setAppearance(_ appearance: ViewAppearance) {
		self.backgroundColor = appearance.backgroundColor
		self.layer.cornerRadius = appearance.cornerRadius
		self.layer.maskedCorners = appearance.maskedCorners
		self.layer.shadowRadius = appearance.shadowRadius
		self.layer.shadowOpacity = appearance.shadowOpacity
		self.layer.shadowOffset = appearance.shadowOffset
		self.layer.shadowColor = appearance.shadowColor
        self.clipsToBounds = appearance.clipsToBounds
        self.layer.masksToBounds = appearance.masksToBounds
		self.layer.borderColor = appearance.borderColor
		self.layer.borderWidth = appearance.borderWidth
        self.translatesAutoresizingMaskIntoConstraints = appearance.translatesAutoresizingMaskIntoConstraints
	}
}

//MARK: - LabelAppearance
public struct LabelAppearance {
	
	public init(text: String? = "",
                textColor: UIColor = .black,
                textAlignment: NSTextAlignment = .left,
                numberOfLines: Int = 1,
                font: UIFont = UIFont.preferredFont(forTextStyle: .body),
                viewAppearance: ViewAppearance = ViewAppearance() ) {
		
        self.text = text
		self.textColor = textColor
		self.textAlignment = textAlignment
		self.numberOfLines = numberOfLines
		self.font = font
		self.viewAppearance = viewAppearance
	}
	
    public var text: String?
	public var textColor: UIColor
	public var textAlignment: NSTextAlignment
	public var numberOfLines: Int
	public var font: UIFont
	
	public var viewAppearance: ViewAppearance
}

public extension UILabel {
	func setAppearance(_ appearance: LabelAppearance) {
        self.text = appearance.text
		self.textColor = appearance.textColor
		self.textAlignment = appearance.textAlignment
		self.numberOfLines = appearance.numberOfLines
		self.font = appearance.font
		
		self.setAppearance(appearance.viewAppearance)
	}
}

//MARK: - TextFieldAppearance
public struct TextFieldAppearance {
	
	public init(textColor: UIColor = .black,
				font: UIFont = UIFont.preferredFont(forTextStyle: .body),
                placeholder: String? = nil,
				textAlignment: NSTextAlignment = .left,
				backgroundImages: (background: UIImage?,
                                   disabled: UIImage?)? = nil,
				borderStyle: UITextField.BorderStyle = .none,
				showsClearButton: UITextField.ViewMode = .never,
				clearsWhenEditing: Bool = false,
				minimumFontSize: CGFloat = 17,
                isEnabled: Bool = true,
				contentType : UITextContentType = .init(rawValue: ""),
				capitalization : UITextAutocapitalizationType = .none,
				correction : UITextAutocorrectionType = .default,
				smartDashes : UITextSmartDashesType = .default,
				smartInsert : UITextSmartInsertDeleteType = .default,
				smartQuotes : UITextSmartQuotesType = .default,
				spellChecking : UITextSpellCheckingType = .default,
				keyboardType : UIKeyboardType = .default,
				keyboardLook : UIKeyboardAppearance = .default,
				returnKey : UIReturnKeyType = .default,
				autoEnableReturnKey : Bool = false,
				secureTextEntry : Bool = false,
                leftImage: UIImage? = nil,
                leftImageSize: CGFloat = 16,
                leftImagePadding: CGFloat = 12,
                leftImageColor: UIColor = .black,
                rightImage: UIImage? = nil,
                rightImageSize: CGFloat = 16,
                rightImagePadding: CGFloat = 12,
                rightImageColor: UIColor = .black,
                
				viewAppearance: ViewAppearance = ViewAppearance()) {
		
		self.textColor = textColor
		self.font = font
        self.placeholder = placeholder
		self.textAlignment = textAlignment
		self.backgroundImages = backgroundImages
		self.borderStyle = borderStyle
		self.showsClearButton = showsClearButton
		self.clearsWhenEditing = clearsWhenEditing
		self.minimumFontSize = minimumFontSize
        self.isEnabled = isEnabled
		self.contentType = contentType
		self.capitalization = capitalization
		self.correction = correction
		self.smartDashes = smartDashes
		self.smartInsert = smartInsert
		self.smartQuotes = smartQuotes
		self.spellChecking = spellChecking
		self.keyboardType = keyboardType
		self.keyboardLook = keyboardLook
		self.returnKey = returnKey
		self.autoEnableReturnKey = autoEnableReturnKey
		self.secureTextEntry = secureTextEntry
        self.leftImage = leftImage
        self.leftImageSize = leftImageSize
        self.leftImagePadding = leftImagePadding
        self.leftImageColor = leftImageColor
        self.rightImage = rightImage
        self.rightImageSize = rightImageSize
        self.rightImagePadding = rightImagePadding
        self.rightImageColor = rightImageColor
        
		self.viewAppearance = viewAppearance
	}
	
	var textColor: UIColor = .black
	var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
    var placeholder: String? = nil
	var textAlignment: NSTextAlignment = .left
	
	var backgroundImages: (background: UIImage?,
                           disabled: UIImage?)? = nil
	
    var borderStyle: UITextField.BorderStyle = .none
	
	var showsClearButton: UITextField.ViewMode = .never
	var clearsWhenEditing: Bool = false
	var minimumFontSize: CGFloat = 17
	
    var isEnabled: Bool = true
	var contentType : UITextContentType = .init(rawValue: "")
	var capitalization : UITextAutocapitalizationType = .none
	var correction : UITextAutocorrectionType = .default
	var smartDashes : UITextSmartDashesType = .default
	var smartInsert : UITextSmartInsertDeleteType = .default
	var smartQuotes : UITextSmartQuotesType = .default
	var spellChecking : UITextSpellCheckingType = .default
	var keyboardType : UIKeyboardType = .default
	var keyboardLook : UIKeyboardAppearance = .default
	var returnKey : UIReturnKeyType = .default
	var autoEnableReturnKey : Bool = false
	var secureTextEntry : Bool = false
    
    var leftImage: UIImage?
    var leftImageSize: CGFloat = 16
    var leftImagePadding: CGFloat = 8
    var leftImageColor: UIColor = .black
    var rightImage: UIImage?
    var rightImageSize: CGFloat = 16
    var rightImagePadding: CGFloat = 8
    var rightImageColor: UIColor = .black
	
	var viewAppearance: ViewAppearance = ViewAppearance()
}

public extension UITextField {
	
	func setAppearance(_ appearance: TextFieldAppearance) {
		
		self.textColor = appearance.textColor
        self.font = UIFont.systemFont(ofSize: 12)
        self.placeholder = appearance.placeholder
		self.textAlignment = appearance.textAlignment
        self.borderStyle = appearance.borderStyle
		
		self.background = appearance.backgroundImages?.background
		self.disabledBackground = appearance.backgroundImages?.disabled
		
		self.clearButtonMode = appearance.showsClearButton
		self.clearsOnBeginEditing = appearance.clearsWhenEditing
		self.minimumFontSize = appearance.minimumFontSize
		
        self.isEnabled = appearance.isEnabled
		self.textContentType = appearance.contentType
		self.autocapitalizationType = appearance.capitalization
		self.autocorrectionType = appearance.correction
		self.smartDashesType = appearance.smartDashes
		self.smartInsertDeleteType = appearance.smartInsert
		self.smartQuotesType = appearance.smartQuotes
		self.spellCheckingType = appearance.spellChecking
		self.keyboardType = appearance.keyboardType
		self.keyboardAppearance = appearance.keyboardLook
		self.returnKeyType = appearance.returnKey
		self.enablesReturnKeyAutomatically = appearance.autoEnableReturnKey
		self.isSecureTextEntry = appearance.secureTextEntry
        
        self.layer.cornerRadius = appearance.viewAppearance.cornerRadius

        self.addImage(leftImage: appearance.leftImage, leftImageSize: appearance.leftImageSize, leftImagePadding: appearance.leftImagePadding, leftImageColor: appearance.leftImageColor, rightImage: appearance.rightImage, rightImageSize: appearance.rightImageSize, rightImagePadding: appearance.rightImagePadding, rightImageColor: appearance.rightImageColor)
        
		self.setAppearance(appearance.viewAppearance)
        self.clipsToBounds = true
	}
    
    func addImage(leftImage: UIImage? = UIImage(),
                  leftImageSize: CGFloat = 16,
                  leftImagePadding: CGFloat = 12,
                  leftImageColor: UIColor = .black,
                  rightImage: UIImage? = UIImage(),
                  rightImageSize: CGFloat = 16,
                  rightImagePadding: CGFloat = 12,
                  rightImageColor: UIColor = .black) {
        
        func createHorizontalPaddingView(withPadding padding: CGFloat) -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: padding).isActive = true
            return view
        }
        
        func createImageToTextPaddingView(withPadding padding: CGFloat) -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: padding).isActive = true
            return view
        }
        
        let leftStackView: UIStackView = .init()
        let leftImageView = UIImageView()
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.image = leftImage
        leftImageView.tintColor = leftImageColor
        leftImageView.widthAnchor.constraint(equalToConstant: leftImageSize).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: leftImageSize).isActive = true
        leftImageView.contentMode = .scaleAspectFit
        leftStackView.clipsToBounds = true

        leftStackView.addArrangedSubview(createHorizontalPaddingView(withPadding: leftImagePadding))
        leftStackView.addArrangedSubview(leftImageView)
        leftStackView.addArrangedSubview(createImageToTextPaddingView(withPadding: leftImagePadding))
        
        self.leftViewMode = .always
        self.leftView = leftStackView
        
        
        let rightStackView: UIStackView = .init()
        let righImageView = UIImageView()
        righImageView.translatesAutoresizingMaskIntoConstraints = false
        righImageView.image = rightImage
        righImageView.tintColor = rightImageColor
        righImageView.widthAnchor.constraint(equalToConstant: rightImageSize).isActive = true
        righImageView.heightAnchor.constraint(equalToConstant: rightImageSize).isActive = true
        righImageView.contentMode = .scaleAspectFit
        righImageView.clipsToBounds = true

        rightStackView.addArrangedSubview(createHorizontalPaddingView(withPadding: rightImagePadding))
        rightStackView.addArrangedSubview(righImageView)
        rightStackView.addArrangedSubview(createImageToTextPaddingView(withPadding: rightImagePadding))
        
        self.rightViewMode = .always
        self.rightView = rightStackView
    }
    
}

//MARK: - ButtonAppearance

public struct ButtonAppearance {
	
	public init(textColor: UIColor = .black,
				textAlignment: NSTextAlignment = .left,
                buttonTitle: String = "",
                contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero,
                imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero,
                buttonImage: UIImage? = UIImage(),
                buttonPosition: UISemanticContentAttribute = .forceRightToLeft,
                tintColor: UIColor = .systemBlue,
				font: UIFont = UIFont.preferredFont(forTextStyle: .body),
                contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
                contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center,
                highlightedColor: UIColor = UIColor(displayP3Red: 244/255,
                                                    green: 247/255,
                                                    blue: 254/255,
                                                    alpha: 1),
                selectedColor: UIColor = UIColor(displayP3Red: 244/255,
                                                 green: 247/255,
                                                 blue: 254/255,
                                                 alpha: 1),
                disbaledColor: UIColor = UIColor(displayP3Red: 244/255,
                                                 green: 247/255,
                                                 blue: 254/255,
                                                 alpha: 1),
				viewAppearance: ViewAppearance = ViewAppearance()) {
		
		self.textColor = textColor
		self.textAlignment = textAlignment
        self.buttonTitle = buttonTitle
        self.contentEdgeInsets = contentEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        self.buttonImage = buttonImage
        self.buttonPosition = buttonPosition
        self.tintColor = tintColor
		self.font = font
        self.contentHorizontalAlignment = contentHorizontalAlignment
        self.contentVerticalAlignment = contentVerticalAlignment
        self.highlightedColor = highlightedColor
        self.selectedColor = selectedColor
        self.disbaledColor = disbaledColor
		self.viewAppearance = viewAppearance
	}
	
	var textColor: UIColor = .black
	var textAlignment: NSTextAlignment = .left
    var buttonTitle: String = ""
    var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    var buttonImage: UIImage? = UIImage()
    var buttonPosition: UISemanticContentAttribute = .forceRightToLeft
    var tintColor: UIColor = .systemBlue
	var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
    var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center
    var contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center
    var highlightedColor: UIColor = UIColor(displayP3Red: 244/255,
                                            green: 247/255,
                                            blue: 254/255,
                                            alpha: 1)
    var selectedColor: UIColor = UIColor(displayP3Red: 244/255,
                                         green: 247/255,
                                         blue: 254/255,
                                         alpha: 1)
    var disbaledColor: UIColor = UIColor(displayP3Red: 244/255,
                                         green: 247/255,
                                         blue: 254/255,
                                         alpha: 1)
	var viewAppearance: ViewAppearance = ViewAppearance()
    var enabled: Bool = false
}

public extension UIButton {
	
	func setAppearance(_ appearance: ButtonAppearance) {
		
		self.setTitleColor(appearance.textColor, for: .normal)
		self.titleLabel?.textAlignment = appearance.textAlignment
        self.setTitle(appearance.buttonTitle, for: .normal)
        self.contentEdgeInsets = appearance.contentEdgeInsets
        self.imageEdgeInsets = appearance.imageEdgeInsets
        self.setImage(appearance.buttonImage, for: .normal)
        self.semanticContentAttribute = appearance.buttonPosition
        self.tintColor = appearance.tintColor
		self.titleLabel?.font = appearance.font
        self.contentHorizontalAlignment = appearance.contentHorizontalAlignment
        self.contentVerticalAlignment = appearance.contentVerticalAlignment
        
        self.setBackgroundColor(appearance.viewAppearance.backgroundColor, for: .normal)
        self.setBackgroundColor(appearance.highlightedColor, for: .highlighted)
        self.setBackgroundColor(appearance.selectedColor, for: .selected)
        self.setBackgroundColor(appearance.disbaledColor, for: .disabled)

        self.layoutIfNeeded()
        let bgImageView = self.subviews.first as? UIImageView
        bgImageView?.layer.cornerRadius = appearance.viewAppearance.cornerRadius
        bgImageView?.clipsToBounds = true
        
		self.setAppearance(appearance.viewAppearance)
	}
    
    func setBackgroundColor(_ color: UIColor, for forState: UIControl.State) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
        
    }

}

//MARK: - StackViewAppearance

public struct StackViewAppearance {
    
    public init(axis: NSLayoutConstraint.Axis = .vertical,
                alignment: UIStackView.Alignment = .fill,
                spacing: CGFloat = 0,
                distribution: UIStackView.Distribution = .fill,
                viewAppearance: ViewAppearance = ViewAppearance()) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
        self.viewAppearance = viewAppearance
    }
    
    var axis: NSLayoutConstraint.Axis = .horizontal
    var alignment: UIStackView.Alignment = .fill
    var spacing: CGFloat = 0
    var distribution: UIStackView.Distribution = .fill
    var viewAppearance: ViewAppearance = ViewAppearance()
}

public extension UIStackView {
    
    func setAppearance(_ appearance: StackViewAppearance) {
        self.axis = appearance.axis
        self.alignment = appearance.alignment
        self.spacing = appearance.spacing
        self.distribution = appearance.distribution
        
        self.setAppearance(appearance.viewAppearance)
    }
}

//MARK: - UINavigationItemAppearance

public struct UINavigationItemAppearance {
    
    public init(title: String? = "",
                leftBarButtonItem: UIBarButtonItem? = nil,
                rightBarButtonItem: UIBarButtonItem? = nil,
                titleView: UIView? = nil) {
        self.title = title
        self.leftBarButtonItem = leftBarButtonItem
        self.rightBarButtonItem = rightBarButtonItem
        self.titleView = titleView
    }
    
    var title: String?
    var leftBarButtonItem: UIBarButtonItem?
    var rightBarButtonItem: UIBarButtonItem?
    var titleView: UIView?
}

extension UINavigationItem {
    
    func setAppearance(_ appearance: UINavigationItemAppearance) {
        self.title = appearance.title
        self.leftBarButtonItem = appearance.leftBarButtonItem
        self.rightBarButtonItem = appearance.rightBarButtonItem
        self.titleView = appearance.titleView
    }
    
}

//MARK: - UIBarButtonItemAppearance

public struct UIBarButtonItemAppearance {
    
    public init(image: UIImage? = nil,
                tintColor: UIColor? = nil,
                imageRenderingMode: UIImage.RenderingMode = .automatic) {
        self.image = image
        self.tintColor = tintColor
        self.imageRenderingMode = imageRenderingMode
    }
    
    var image: UIImage?
    var tintColor: UIColor?
    var imageRenderingMode: UIImage.RenderingMode = .automatic
}

extension UIBarButtonItem {
    
    func setAppearance(_ appearance: UIBarButtonItemAppearance) {
        self.image = appearance.image
        self.tintColor = appearance.tintColor
        self.image?.withRenderingMode(appearance.imageRenderingMode)
    }
    
}

//MARK: - UIImageViewAppearance

public struct UIImageViewAppearance {
    
    public init(image: UIImage? = nil,
                tintColor: UIColor? = nil,
                imageRenderingMode: UIImage.RenderingMode = .automatic,
                viewAppearance: ViewAppearance = ViewAppearance()) {
        self.image = image
        self.tintColor = tintColor
        self.imageRenderingMode = imageRenderingMode
        self.viewAppearance = viewAppearance
    }
    
    var image: UIImage?
    var tintColor: UIColor?
    var imageRenderingMode: UIImage.RenderingMode = .automatic
    var viewAppearance: ViewAppearance = ViewAppearance()
}

extension UIImageView {
    
    func setAppearance(_ appearance: UIImageViewAppearance) {
        self.image = appearance.image
        self.tintColor = appearance.tintColor
        self.image?.withRenderingMode(appearance.imageRenderingMode)
        
        self.setAppearance(appearance.viewAppearance)
    }
    
}

//MARK:  UISwitchAppearance

public struct UISwitchAppearance {
    
    public init(onTintColor: UIColor = .blue,
                offTintColor: UIColor = .systemGray5,
                thumbnailScaleSize: (scaleX: CGFloat,scaleY: CGFloat) =  (scaleX: 1, scaleY: 1),
                viewAppearance: ViewAppearance = ViewAppearance()) {
        
        self.onTintColor = onTintColor
        self.offTintColor = offTintColor
        self.thumbnailScaleSize = thumbnailScaleSize
        self.viewAppearance = viewAppearance
    }
    
    var onTintColor: UIColor = .blue
    var offTintColor: UIColor = .systemGray5
    var thumbnailScaleSize: (scaleX: CGFloat, scaleY: CGFloat) =  (scaleX: 1, scaleY: 1)
    var viewAppearance: ViewAppearance = ViewAppearance()
}

public extension UISwitch {
    
    func setAppearance(_ appearance: UISwitchAppearance) {
        self.onTintColor = appearance.onTintColor
        self.tintColor = appearance.offTintColor
        self.layer.cornerRadius = self.frame.height / 2.0
        self.backgroundColor = appearance.offTintColor
        self.clipsToBounds = true
        self.setThumbSize(scaleX: appearance.thumbnailScaleSize.scaleX, scaleY: appearance.thumbnailScaleSize.scaleY)
        
        self.setAppearance(appearance.viewAppearance)
    }
    
    func setThumbSize(scaleX: CGFloat, scaleY: CGFloat){
        if let thumb = self.subviews[0].subviews[1].subviews[2] as? UIImageView {
            thumb.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }
    }
}
