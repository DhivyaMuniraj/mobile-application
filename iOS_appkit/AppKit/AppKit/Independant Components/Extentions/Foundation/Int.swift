//
//  Int.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
// random number generator

@available(iOS 11.0, *)
public extension Int {
    init(_ range: Range<Int> ) {
        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
        let min = UInt32(range.startIndex + delta)
        let max = UInt32(range.endIndex   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
    func random(digits:Int) -> Int {
        let min = Int(pow(Double(10), Double(digits-1))) - 1
        let max = Int(pow(Double(10), Double(digits))) - 1
        return Int(min..<max)
    }
}
