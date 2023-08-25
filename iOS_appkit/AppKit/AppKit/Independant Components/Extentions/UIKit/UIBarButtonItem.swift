//
//  UIBarButtonItem.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UIBarButtonItem {
    func setSize(width: CGFloat, height: CGFloat) {
        let widthContraint = self.customView?.widthAnchor.constraint(equalToConstant: width)
        widthContraint?.isActive = true
        let heightConstraint = self.customView?.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
    }
}
