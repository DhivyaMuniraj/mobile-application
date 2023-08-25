//
//  UITextField.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UITextField {
	var textOrEmpty: String { self.text ?? "" }
}
