//
//  ForgotPasswordViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 22/09/22.
//

import Foundation

protocol ForgotPasswordCoordinatorDelegate: NSObject {
    func forgotPasswordDidComplete()
}

class ForgotPasswordViewModel {
    
    weak var delegate: ForgotPasswordCoordinatorDelegate?
    
    init(delegate: ForgotPasswordCoordinatorDelegate) {
        self.delegate = delegate
    }
    
    func initiatePasswordRecoveryFor(email: String) {
        self.delegate?.forgotPasswordDidComplete()
    }
    
}
