//
//  NoInternetAlert.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import UIKit

public protocol NoInternetAlertProtocol: AnyObject {
	func showPopup()
	func hidePopup()
}


public class NoInternetAlertManager: NoInternetAlertProtocol {
	
	let noInternetVC: UIViewController
	weak var window: UIWindow?
	
	init(window: UIWindow?, noInternetVC: UIViewController) {
		
		self.noInternetVC = noInternetVC
		
		self.window = window
		self.window?.addSubview(noInternetVC.view)
	}
	
	public func showPopup() {
		
		DispatchQueue.global().async {
			DispatchQueue.main.async {
				
				if let noInternetVCView = self.noInternetVC.view {
					
					self.window?.bringSubviewToFront(noInternetVCView)
					self.updateNoInternetViewFrame()
					self.noInternetVC.view.isHidden = false
				}
				
			}
		}
		
	}
	
	public func hidePopup() {
		
		DispatchQueue.global().async {
			DispatchQueue.main.async {
				
				if let noInternetVCView = self.noInternetVC.view {
					
					self.window?.bringSubviewToFront(noInternetVCView)
					self.updateNoInternetViewFrame()
					self.noInternetVC.view.isHidden = true
				}
				
			}
		}
		
	}
	
	private func updateNoInternetViewFrame() {
		
		self.noInternetVC.view.setNeedsLayout()
		self.noInternetVC.view.layoutIfNeeded()
		
		self.noInternetVC.view.frame = UIScreen.main.bounds
	}
}
