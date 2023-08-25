//
//  LoginViewModel.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//

import Foundation
import Combine

protocol LoginCoordinatorrDelegate: NSObject {
    func loginDidComplete(user: User)
    func startSignup()
    func startForgotPassword()
}

class LoginViewModel {
    enum LoginViewState {
        case loading
        case loggedIn(User)
        case error(Error)
    }
    
    weak var delegate: LoginCoordinatorrDelegate?
    let loginService: AnyLoginService
    var isLoading = CurrentValueSubject<Bool,Never>(false)
    var viewState = CurrentValueSubject<LoginViewState?,Never>(nil)
    private lazy var queue = DispatchQueue.init(label: "\(type(of: self)).StateTransactionQueue")
    
    init(delegate: LoginCoordinatorrDelegate, loginService: AnyLoginService) {
        self.delegate = delegate
        self.loginService = loginService
    }
    
    func signupAction() {
        self.delegate?.startSignup()
    }
    
    func forgotPasswordAction() {
        self.delegate?.startForgotPassword()
    }
    
    func loginDidComplete(user: User) {
        self.delegate?.loginDidComplete(user: user)
    }
    
    func loginAction() {
        write { viewState.value = LoginViewState.loading }
        Task { @MainActor in
            do {
                let user = try await loginService.loginWith(email: "", password: "")
                write { viewState.value = LoginViewState.loggedIn(user) }
            } catch {
                write { viewState.value = LoginViewState.error(error) }
            }
        }
    }
    
    private func write(_ block: () -> Void) {
        queue.sync {
            block()
        }
    }
    
}
