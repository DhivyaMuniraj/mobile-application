//
//  Coordinator.swift
//  AppKit
//
//  Created by Jim Allan C on 21/09/22.
//
import Foundation

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    
    func start(onDismissed: (() -> Void)?)
    func dismiss(animated: Bool)
    func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)?)
}
extension Coordinator {
    func dismiss(animated: Bool) {
        router.dismiss(animated: true)
    }
    
    func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)? = nil) {
        children.append(child)
        child.start(onDismissed: { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.removeChild(child)
            onDismissed?()
        })
    }
    
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where:  { $0 === child })
        else {
            return
        }
        children.remove(at: index)
    }
}
