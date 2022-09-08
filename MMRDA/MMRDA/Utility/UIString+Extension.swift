//
//  UIString+Extension.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation
import UIKit
import Foundation
import UIKit
import MobileCoreServices
import CommonCrypto
import GoogleMaps
import UIKit


extension String {
    func getAttributedStrijng(titleString:String,subString:String ,subStringColor:UIColor) -> NSAttributedString {
        
        let attrStri = NSMutableAttributedString.init(string:titleString)
        let nsRange = NSString(string: titleString).range(of: subString, options: String.CompareOptions.caseInsensitive)
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor :subStringColor, NSAttributedString.Key.font: UIFont.init(name: "Roboto-Bold", size: 17.0) as Any], range: nsRange)
        return attrStri
    }
}


extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        
        return String(data: theJSONData, encoding: .utf8)
    }
    
    var toJson: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        
        return String(data: theJSONData, encoding: .ascii)
    }
    
   
    
}

extension String {
    
    func replace(_ string: String, replacementString: String) -> String {
       
       return self.replacingOccurrences(of: string, with: replacementString, options: NSString.CompareOptions.literal, range: nil)
   }
   
    
    
    func removeWhitespaceInString() -> String {
        
        return self.replace(" ", replacementString: "")
    }
    
    func removeCharacterInCharacterSet(_ set: CharacterSet) -> String  {
        let tempArr = self.components(separatedBy: set)
        return tempArr.joined(separator: "")
        
    }
    
    /**
     Returns the substring in the given range
     
     - parameter range: specify the range to get string
     - returns: Substring in range
     */
    subscript (range: Range<Int>) -> String? {
        
        if range.lowerBound < 0 || range.upperBound > self.length {
            return nil
        }
        
        //        let range = Range(start: startIndex.advancedBy(range.startIndex), end: startIndex.advancedBy(range.endIndex))
        let range = self.index(startIndex, offsetBy: range.lowerBound) ..< self.index(startIndex, offsetBy: range.upperBound)
        return String(self[range])
    }
    
    
   
    
    
    var LocalizedString: String {
        //return NSLocalizedString(self, comment: "")
        
        guard let code = languageCode as? String else {
            return NSLocalizedString(self, comment: "")
        }
        let path = Bundle.main.path(forResource: code, ofType: "lproj")
            let bundle = Bundle(path: path!)

            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }
    
    /**
     String length
     */
    var length: Int { return self.count }
    
    /**
     Reverse of string
     */
    var reverse: String { return String(self.reversed()) }
    
    func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
    func mobileNumberValidation() -> Bool {
        if self.trim().count == 10 {
            return true
        }
        return false
    }
    func MpinValidation() -> Bool {
        if self.trim().count == 4 {
            return true
        }
        return false
    }
    /**
     trim String
     */
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    func isValidPassword() -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
        
    }
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    var parseJSONString: AnyObject?
    {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray
                {
                    print(jsonResult)
                    return jsonResult //Will return the json array output
                }
                else
                {
                    return nil
                }
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else
        {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    
    /**
     Get height of string
     
     - parameter width: Max width of string to calculate height
     - parameter font:  Font of string
     
     - returns: Height of string
     
     func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
     let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
     let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
     
     return boundingBox.height
     }
     */
    /**
     Get width of string
     
     - parameter width: Max width of string to calculate height
     - parameter font:  Font of string
     
     - returns: Height of string
     
     func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
     
     let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
     
     return ceil(boundingBox.width)
     }
     */
    
    
    /**
     Get nsdata from string
     
     - returns: A NSdata from string
     
     func toData () -> Data {
     
     return self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
     }
     */
    
    
    /**
     Returns an array of strings, each of which is a substring of self formed by splitting it on separator.
     
     - parameter separator: Character used to split the string
     - returns: Array of substrings
     
     func explode (_ separator: Character) -> [String] {
     
     return self.characters.split(whereSeparator: { (element: Character) -> Bool in
     return element == separator
     }).map { String($0) }
     }
     */
    /**
     Specify that string contains only letters.
     
     - returns: A Bool return true if only letters otherwise false.
     */
    func containsOnlyLetters () -> Bool {
        
        for chr in self {
            if (!(chr >= "a" && chr <= "z") || !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    /**
     Split the string with specific character or symbol
     - returns: A String Value with array formate
     */
    func split(regex pattern: String) -> [String] {
        
        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
        else { return [] }
        
        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
    
    /**
     Specify that string contains only number.
     
     - returns: A Bool return true if string has only letters otherwise false.
     */
    func containOnlyNumber () -> Bool {
        
        let num = Int(self)
        if num != nil {
            return true
        } else {
            return false
        }
    }
    
    
    /**
     Get array from string
     
     - parameter seperator: String to seperate array
     
     - returns: Array from string
     */
    func toArray (_ seperator: String) -> [String] {
        
        return self.components(separatedBy: seperator)
    }
    
    
    
    /**
     Get substring in string.
     
     - returns: A Bool return true if string has substring otherwise false.
     */
    func containsSubstring () -> Bool {
        
        return self.contains(self)
    }
    
    func getLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let utcDate = dateFormatter.date(from: self)
        
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        var localDateStr = ""
        if utcDate == nil {
            // do nothing
        } else {
            
            localDateStr = dateFormatter.string(from: utcDate!)
        }
        return localDateStr
    }
    
    func getCurrentDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let utcDate = dateFormatter.date(from: self)
        return utcDate!
        
    }
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let utcDate = dateFormatter.date(from: self)
        
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        var localDateStr = ""
        if utcDate == nil {
            // do nothing
        } else {
            
            localDateStr = dateFormatter.string(from: utcDate!)
        }
        return localDateStr
    }
    
    func convertToUTC() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        let localDate = dateFormatter.date(from: self)
        
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.string(from: localDate!)
        
        return date
    }
    
    func attributedStringWithColor(_ strings: [String], color : UIColor, fontSize : UIFont , characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attributedString.addAttribute(NSAttributedString.Key.font, value: fontSize, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value: fontSize, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}



extension UIButton {
    func underline() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:20, y: self.bounds.height - 10, width:(self.frame.size.width - 40), height:2)
        bottomLine.backgroundColor = Colors.APP_Theme_color.value.cgColor
        self.layer.addSublayer(bottomLine)
    }
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
