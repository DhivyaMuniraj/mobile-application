//
//  UIColor.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UIColor {
	class func hex(_ hex: String) -> UIColor {
		let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255


					return self.init(red: r, green: g, blue: b, alpha: 1.0)
                }
            }
        }

		print(#function)
		fatalError("Invalid Hex String :- \(hex)")
		return .clear
	}
}
