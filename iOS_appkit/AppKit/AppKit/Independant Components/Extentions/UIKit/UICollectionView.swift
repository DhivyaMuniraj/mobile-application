//
//  Dictionary.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UICollectionView {
	func register(_ nibs: (nib: UINib, forSupplementaryViewOfKind: String, withReuseIdentifier: String)...) {
		nibs.forEach {
			nib, elementKind, reuseId in
				self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: reuseId)
		}
	}
	func register(_ nibs: (nib: UINib, withReuseIdentifier: String)...) {
		nibs.forEach {
			nib, reuseId in
			self.register(nib, forCellWithReuseIdentifier: reuseId)
		}
	}
}
