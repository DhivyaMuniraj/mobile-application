//
//  AppFont.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import UIKit

public struct AppFont {
	
	public init() { }
	
	public let montserratRegular: UIFont = UIFont.init(name: "Montserrat-Regular", size: 1)!
	public let montserratMedium: UIFont = UIFont.init(name: "Montserrat-Medium", size: 1)!
	public let montserratSemiBold: UIFont = UIFont.init(name: "Montserrat-SemiBold", size: 1)!
	public let montserratBold: UIFont = UIFont.init(name: "Montserrat-Bold", size: 1)!
}

public extension UIFont {
	
	func withSize(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
		
		self.withSize(UIFont.preferredFont(forTextStyle: textStyle).pointSize)
	}
}
