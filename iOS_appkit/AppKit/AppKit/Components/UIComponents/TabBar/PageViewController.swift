//
//  PageViewController.swift
//  AppKit
//
//  Created by Jyoti Luhana on 13/09/22.
//

import UIKit

class PageViewController: UIPageViewController {

    var pages: [UIViewController] = [UIViewController]()
    
    var selectedPage: Int  = 0
    
    var currentIndex: Int {
        if let visibleViewController = viewControllers?.first,
           let ci = pages.firstIndex(of: visibleViewController) {
            return ci
        }
        else {
            return 0
        }
    }
    
    init(viewControllers: [UIViewController], selectedPage: Int = 0) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = viewControllers
        self.selectedPage = selectedPage
        
        self.setViewControllers([viewControllers[selectedPage]], direction: .forward, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func go(toIndex: Int) {
        setViewControllers(
            [pages[toIndex]],
            direction: ((currentIndex < toIndex) ? .forward : .reverse),
            animated: true)
    }
    
}

