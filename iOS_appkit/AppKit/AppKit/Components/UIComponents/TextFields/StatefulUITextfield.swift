//
//  StatefulUITextfield.swift
//  AppKit
//
//  Created by Jyoti Luhana on 30/08/22.
//

import Foundation
import UIKit

class StatefulUITextfield: UITextField, UITextFieldDelegate {
    
    weak var passthroughDelegate: UITextFieldDelegate?
    
    private var defaultAppearance: TextFieldAppearance
    private var filledAppearance: TextFieldAppearance
    private var typingAppearance: TextFieldAppearance
    private var successAppearance: TextFieldAppearance
    private var errorAppearance: TextFieldAppearance
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    init(withAppearances defaultAppearance: TextFieldAppearance, filledAppearance: TextFieldAppearance, typingAppearance: TextFieldAppearance, successAppearance: TextFieldAppearance, errorAppearance: TextFieldAppearance) {
        
        self.defaultAppearance = defaultAppearance
        self.filledAppearance = filledAppearance
        self.typingAppearance = typingAppearance
        self.successAppearance = successAppearance
        self.errorAppearance = errorAppearance
        
        super.init(frame: .zero)
        self.delegate = self
    }
    
}

extension StatefulUITextfield {
    
    
    @available(iOS 2.0, *)
    // return NO to disallow editing.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return (passthroughDelegate?.textFieldShouldBeginEditing?(textField)) ?? true
    }

    @available(iOS 2.0, *)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passthroughDelegate?.textFieldDidBeginEditing?(textField)
        self.setAppearance(typingAppearance)
        
    } // became first responder

    @available(iOS 2.0, *)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return passthroughDelegate?.textFieldShouldEndEditing?(textField) ?? true
    } // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

    @available(iOS 2.0, *)
    func textFieldDidEndEditing(_ textField: UITextField) {
        passthroughDelegate?.textFieldDidEndEditing?(textField)
    } // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        passthroughDelegate?.textFieldDidEndEditing?(textField, reason: reason)
        if textField.text == "" {
            self.setAppearance(errorAppearance)
        } else {
            self.setAppearance(successAppearance)
        }
    } // if implemented, called in place of textFieldDidEndEditing:

    
    @available(iOS 2.0, *)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return passthroughDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    } // return NO to not change text

    
    @available(iOS 13.0, *)
    func textFieldDidChangeSelection(_ textField: UITextField) {
        passthroughDelegate?.textFieldDidChangeSelection?(textField)
    }

    
    @available(iOS 2.0, *)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return passthroughDelegate?.textFieldShouldClear?(textField) ?? true
    }// called when clear button pressed. return NO to ignore (no notifications)

    @available(iOS 2.0, *)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  {
        return passthroughDelegate?.textFieldShouldReturn?(textField) ?? true
    }// called when 'return' key pressed. return NO to ignore.
}
