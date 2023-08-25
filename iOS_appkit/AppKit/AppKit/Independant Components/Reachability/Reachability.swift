//
//  Reachability.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import Network

public protocol ReachabilityMonitorDelegate: AnyObject {
	func didUpdatePath(path: NWPath)
}

public class Reachability: ReachabilityMonitorDelegate {
	
	private let networkMonitor: ReachabilityMonitor
	private let noInternetAlert: NoInternetAlertProtocol?
	
	public weak var delegate: ReachabilityMonitorDelegate?
	
	public init(networkMonitor: ReachabilityMonitor,
		 noInternetPopupManager: NoInternetAlertProtocol?) {
		
		self.networkMonitor = networkMonitor
		self.noInternetAlert = noInternetPopupManager
		
		self.networkMonitor.delegate = self
	}
	
	public func didUpdatePath(path: NWPath) {
		delegate?.didUpdatePath(path: path)
		
		if path.status == .satisfied {
			
			noInternetAlert?.hidePopup()
			
		} else {
			
			noInternetAlert?.showPopup()
		}
	}
}

public class ReachabilityMonitor {
	public weak var delegate : ReachabilityMonitorDelegate?
	
	private let monitor: NWPathMonitor = .init()
	private let neworkQueue: DispatchQueue = .init(label: "com.appKit.networkMonitorQueue")
	
	public func startMonitoring() {
		monitor.pathUpdateHandler = { path in
			self.delegate?.didUpdatePath(path: path)
		}
		
		monitor.start(queue: neworkQueue)
	}
	
}
