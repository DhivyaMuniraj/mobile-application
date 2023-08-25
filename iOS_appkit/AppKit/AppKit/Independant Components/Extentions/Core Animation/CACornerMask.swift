//
//  CACornerMask.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
extension CACornerMask {
    public static var topLeft: CACornerMask     = .layerMinXMinYCorner//{ get }
    public static var topRight: CACornerMask    = .layerMaxXMinYCorner //{ get }
    public static var bottomLeft: CACornerMask  = .layerMinXMaxYCorner //{ get }
    public static var bottomRight: CACornerMask = .layerMaxXMaxYCorner //{ get }
}
