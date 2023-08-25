//
//  URLSessionGenerator.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation

public struct URLSessionGenerator {
	
	let backgroundSessionID: String
	let maxTimeout: TimeInterval
	let userAgentName: String
	
	init(backgroundSessionID: String, maxTimeout: TimeInterval, userAgentName: String) {
		self.backgroundSessionID = backgroundSessionID
		self.maxTimeout = maxTimeout
		self.userAgentName = userAgentName
	}
	
	
	func getSession(delegate: URLSessionDelegate?,
					delegateQueue: OperationQueue?) -> URLSession {
		
		let config = URLSessionConfiguration.default
		config.timeoutIntervalForRequest = maxTimeout
		config.timeoutIntervalForResource = maxTimeout
		config.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
		
		if let headers = config.httpAdditionalHeaders, let userAgent = headers["User-Agent"] as? String  {
			config.httpAdditionalHeaders?["User-Agent"] = userAgent + ";" + userAgentName
		} else {
			config.httpAdditionalHeaders?["User-Agent"] = userAgentName
		}
		
		return URLSession(configuration: config, delegate: delegate, delegateQueue: delegateQueue)
	}
	
	func getBackgroundSession(delegate: URLSessionDelegate, delegateQueue: OperationQueue) -> URLSession {
		
		let config = URLSessionConfiguration.background(withIdentifier: backgroundSessionID)
		config.sessionSendsLaunchEvents = true
		
		let session = URLSession(configuration: config,
								 delegate: delegate,
								 delegateQueue: delegateQueue)
		return session
	}
}
