//
//  LoginService.swift
//  AppKit
//
//  Created by Jim Allan C on 23/09/22.
//

import Foundation

enum LoginError: LocalizedError {
    case invalidCredentials
    case serverIssue
}

protocol AnyLoginService {
    func loginWith(email: String, password: String) async throws -> User
}

final class BasicLoginService: AnyLoginService {
    
    func loginWith(email: String, password: String) async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                continuation.resume(returning: User.init(email: "", displayName: ""))
            }
        }
    }
    
}

