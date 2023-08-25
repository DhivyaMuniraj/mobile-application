//
//  Array.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation

@available(iOS 11.0, *)
public extension Array where Element: Hashable {

    func next(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index + 1 <= self.count {
            return index + 1 == self.count ? self[0] : self[index + 1]
        }
        return nil
    }

    func prev(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index >= 0 {
            return index == 0 ? self.last : self[index - 1]
        }
        return nil
    }
	func uniqued() -> [Element] {
		var seen = Set<Element>()
		return filter{ seen.insert($0).inserted }
	}
}
