//
//  Data.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation

@available(iOS 11.0, *)
public extension Data {
    func pruned(dropFirstSpaceChar shouldDropFirst: Bool = false) -> Data? {
        let data = self
        var responseString = String(data: data, encoding: .utf8) ?? ""
        if shouldDropFirst && responseString.first == " " {
            responseString = String(responseString.dropFirst())
        }
        let prunedData = responseString.data(using: .utf8)
        return prunedData
    }
}
