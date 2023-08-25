//
//  UIFont.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UIFont {
    class var title: UIFont {
        return UIFont.preferredFont(forTextStyle: .title3)
    }
}
