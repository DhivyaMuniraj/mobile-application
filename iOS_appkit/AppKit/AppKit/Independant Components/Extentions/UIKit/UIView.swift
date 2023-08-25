//
//  UIView.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UIView {
	
	// Using a function since `var image` might conflict with an existing variable
	// (like on `UIImageView`)
	func asImage() -> UIImage {
//		if #available(iOS 10.0, *) {
			let renderer = UIGraphicsImageRenderer(bounds: bounds)
			return renderer.image { rendererContext in
				layer.render(in: rendererContext.cgContext)
			}
//		} else {
//			UIGraphicsBeginImageContext(self.frame.size)
//			self.layer.render(in:UIGraphicsGetCurrentContext()!)
//			let image = UIGraphicsGetImageFromCurrentImageContext()
//			UIGraphicsEndImageContext()
//			return UIImage(cgImage: image!.cgImage!)
//		}
	}
}

@available(iOS 11.0, *)
public extension UIView {
    ///superview is anchored to subview, eg superview.anchor(top: subview.topAnchor)
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        //translate the view's autoresizing mask into Auto Layout constraints
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

@available(iOS 11.0, *)
public extension UIView {

    /**
     Usage-
     subview.translatesAutoresizingMaskIntoConstraints = false
     let constraints = subview.constraintsForAnchoringTo(boundsOf: superview)
     NSLayoutConstraint.activate(constraints)
     self.view.layoutIfNeeded()
     **/
	func constraintsForAnchoringTo(boundsOf superView: UIView) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor),
            self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor)
        ]
    }
    
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
    
    func dropShadow(color: UIColor = UIColor.black, offset: CGSize = CGSize(width: 1, height: 1), scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropShadow(color: UIColor = UIColor.black, offset: CGSize = CGSize(width: 1, height: 1), opacity: Float = 2, radius: CGFloat = 0.8, cornerRadius: CGFloat) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius

        layer.insertSublayer(shadowLayer, at: 0)
    }
    func curvedviewShadow(cornerRadius: CGFloat = 8){
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.35
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner,
                                    .layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

@available(iOS 11.0, *)
public extension UIView {
	
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
	
	func addDiagonalGradiant(_ colors: [UIColor]) {
        let GradientLayerName = "diagonalGradientLayer"
        
        if let oldlayer = self.layer.sublayers?.filter({$0.name == GradientLayerName}).first {
            oldlayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
		gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1 )
        gradientLayer.frame = self.bounds
        gradientLayer.masksToBounds = true
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.maskedCorners = self.layer.maskedCorners
        gradientLayer.name = GradientLayerName
        
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addVerticalGradiant(withColors colors: [UIColor] = []) {
        let GradientLayerName = "vgradientLayer"
        
        if let oldlayer = self.layer.sublayers?.filter({$0.name == GradientLayerName}).first {
            oldlayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
		gradientLayer.colors = colors.map { $0.cgColor }
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.masksToBounds = true
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.maskedCorners = self.layer.maskedCorners
        gradientLayer.name = GradientLayerName

        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func addHorizontalGradiant(withColors colors: [UIColor] = []) {
        let GradientLayerName = "hgradientLayer"
        
        if let oldlayer = self.layer.sublayers?.filter({$0.name == GradientLayerName}).first {
            oldlayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.masksToBounds = true
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.maskedCorners = self.layer.maskedCorners
        gradientLayer.name = GradientLayerName

        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 2, cornerRadius: CGFloat = 10, dashPattern: [NSNumber] = [8,6]) {
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func AddShadowToButton(cornerRadiusVal : CGFloat , shadowRadiusVal : CGFloat)  {
        
        self.layer.cornerRadius = cornerRadiusVal
        self.layer.shadowRadius = shadowRadiusVal
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
	
}
