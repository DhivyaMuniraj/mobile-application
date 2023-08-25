//
//  ServiceLocator.swift
//  AppKit
//
//  Created by Jim Allan C on 25/09/22.
//

import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()
    private init() { }
    private lazy var reg: [String: AnyObject] = [:]

    func addService<T>(service: T) {
        let key = "\(type(of: service))"
        reg[key] = service as AnyObject
    }

    func getService<T>() -> T? {
        let key = "\(T.self)"
        return reg[key] as? T
    }
    
}
