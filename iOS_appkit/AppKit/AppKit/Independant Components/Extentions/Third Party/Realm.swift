//
//  Realm.swift
//  AppKit
//
//  Created by Chaitanya Soni on 26/08/22.
//

/*
import Foundation
import UIKit
import Realm
import RealmSwift

protocol RealmListDetachable {
    
    func detached() -> Self
}

extension List: RealmListDetachable where Element: Object {
    
    func detached() -> List<Element> {
        let detached = self.detached
        let result = List<Element>()
        result.append(objectsIn: detached)
        return result
    }
    
}

@objc extension Object {
    
    public func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            if let detachable = value as? Object {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else if let list = value as? RealmListDetachable {
                detached.setValue(list.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

extension Sequence where Iterator.Element: Object {
    
    public var detached: [Element] {
        return self.map({ $0.detached() })
    }
    
}

*/
