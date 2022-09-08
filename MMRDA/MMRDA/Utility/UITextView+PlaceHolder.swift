//
//  UITextView+PlaceHolder.swift
//  MMRDA
//
//  Created by Kirti Chavda on 06/09/22.
//

import Foundation
import UIKit
@IBDesignable
class PlaceHolderTextView: UITextView {

    @IBInspectable var placeholder: String = "" {
         didSet{
             updatePlaceHolder()
        }
    }

    @IBInspectable var placeholderColor: UIColor = UIColor.gray {
        didSet {
            updatePlaceHolder()
        }
    }

    private var originalTextColor = UIColor.black
    private var originalText: String = ""

    private func updatePlaceHolder() {

        if self.text == "" || self.text == placeholder  {

            self.text = placeholder
            self.textColor = placeholderColor
//            if let color = self.textColor {
//
//                self.originalTextColor = color
//            }
            self.originalText = ""
        } else {
            self.textColor = self.originalTextColor
            self.originalText = self.text
        }

    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.text = self.originalText
        self.textColor = self.originalTextColor
        return result
    }
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updatePlaceHolder()

        return result
    }
}
