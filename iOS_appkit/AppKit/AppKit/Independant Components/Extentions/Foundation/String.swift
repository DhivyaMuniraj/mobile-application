//
//  String.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension String {
	@inlinable var isntEmpty: Bool { return !isEmpty }
    
	var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
	var isValidPhone: Bool {
//        let regex = "^09[0-9'@s]{9,9}$"
        let regex = "^[6-9][0-9]{9}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
	var isPhoneNumber: Bool {

//        let charcter  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let set = CharacterSet(charactersIn: "+0123456789").inverted
        var filtered:String!
        let inputString:[String] = self.components(separatedBy: set)
        filtered = inputString.joined(separator: "")
        return  self == filtered

    }
	func toDateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        var date = formatter.date(from: self)// ?? Date()
        
        let formatter2 = DateFormatter()
        formatter2.locale = Locale(identifier: "en_US_POSIX")
        formatter2.dateFormat = format
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = formatter.date(from: self) ?? Date()
        
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        date = formatter.date(from: self) ?? Date()
        if date != nil {
            return formatter2.string(from: date ?? Date())//date
        }else {
            formatter.dateFormat = "yyyy-dd-MM HH:mm:ss"
            date = formatter.date(from: self) ?? Date()
            return formatter2.string(from: date ?? Date())//date
        }
		
	}
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension String {

    mutating func attributedString(fontsize : Int) -> NSAttributedString
    {
        if self.contains(".") {
            if self.suffix(2).contains(".") {
                self.append("00")
            } else if self.suffix(3).contains(".") {
                self.append("0")
            }
        } else {
           self.append(".000")
        }
        
        let amt = self.count - 3
        let unit = self.prefix(3)
        let secondWord = self.suffix(amt)
        //let amount = secondWord.prefix(amt-4)
        let decimal = secondWord.suffix(3)
        
        let attributedText = NSMutableAttributedString(string: self)
        let attrs      = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(fontsize))]
        let attrs1      = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(fontsize))]
        let range = NSString(string: self).range(of: String(unit))
        let range2 = NSString(string: self).range(of: String(decimal))
        
        attributedText.addAttributes(attrs, range: range)
        attributedText.addAttributes(attrs1, range: range2)
        return attributedText
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
extension String {
    // MARK - Parse into NSDate
    
    func dateFromFormat(_ format: String) -> Date? {
        let formatter = DateFormatter()
//        formatter.locale = Locale.autoupdatingCurrent
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = Calendar.autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

// "Montserrat-Medium"
public extension String {
    
    func maskedPhoneNumber() -> String {
        
        let characters = Array(self)
        var tempAry = [Character]()
        
        for i in 0..<characters.count {
            
            if i >= characters.count - 4 {
                tempAry.append(characters[i])
            } else {
                tempAry.append("X")
            }
        }
        let str = String(tempAry)
        
        return str
    }
    
    func setAmount(pointSize: CGFloat) -> NSMutableAttributedString {
        // guard let appFont = SalesSDK.appFont else { return }
        
        let amountBeforeDot = (self.components(separatedBy: ".").first ?? "") + "."
        var amountAfterDot: String = self.components(separatedBy: ".").last ?? ""
        
        if self.components(separatedBy: ".").count <= 1 {
           amountAfterDot = "00"
        }
        let rs = "₹ "
        let attributedString = NSMutableAttributedString(string: rs,
                                                         attributes: [NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: pointSize - 5) ?? UIFont.systemFont(ofSize: pointSize - 5)])
        attributedString.append(NSAttributedString(string: amountBeforeDot,
                                                   attributes: [NSAttributedString.Key.font : UIFont(name: "Montserrat-Medium", size: pointSize) ?? UIFont.systemFont(ofSize: pointSize)]))
        attributedString.append(NSAttributedString(string: amountAfterDot,
                                                   attributes: [NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: pointSize - 5) ?? UIFont.systemFont(ofSize: pointSize - 5)]))
        
       return attributedString
    }
}
