//
//  Double.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

public extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    
    func roundToDecimalPoint(_ fractionDigits: Int) -> String {
        return String(format: "%.\(fractionDigits)f", self)
    }
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 3
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
    ///currencyPrefix: String doesnt need padding
    func toCurrencyString(currencyPrefix: String = "₹", fonts: (currencyFont: UIFont?, beforeDecimalFont: UIFont?, afterDecimalFont: UIFont?), roundedTo: Int) -> NSMutableAttributedString {
//        let val = self.roundToDecimalPoint(2)
//        print(val)
//        let commaVal = Double(val)?.withCommas() ?? "0.00"
//        print(commaVal)
        var myString = Double(self.roundToDecimalPoint(roundedTo))?.withCommas() ?? "0,00"
        if !myString.contains(".") {
           myString += ".00"
        }
        let amountBeforeDot = (myString.components(separatedBy: ".").first ?? "") + "."
        var amountAfterDot: String = myString.components(separatedBy: ".").last ?? ""
        
        if myString.components(separatedBy: ".").count <= 1 {
           amountAfterDot = "00"
        }
        
        if amountAfterDot.count == 1 {
            amountAfterDot += "0"
        }
        
        let attributedString = NSMutableAttributedString(string: "\(currencyPrefix) ",
                                                         attributes: [NSAttributedString.Key.font : fonts.currencyFont ?? UIFont.preferredFont(forTextStyle: .caption2)])
        attributedString.append(NSAttributedString(string: amountBeforeDot,
                                                   attributes: [NSAttributedString.Key.font : fonts.beforeDecimalFont ?? UIFont.preferredFont(forTextStyle: .body)]))
        attributedString.append(NSAttributedString(string: amountAfterDot,
                                                   attributes: [NSAttributedString.Key.font : fonts.afterDecimalFont ?? UIFont.preferredFont(forTextStyle: .caption2)]))
        
       return attributedString
    }
}

