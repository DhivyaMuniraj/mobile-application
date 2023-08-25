//
//  Date.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation


@available(iOS 11.0, *)
public extension Date {
	
	func stringWithFormat(format: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = .init(identifier: "en")
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}
	
}
