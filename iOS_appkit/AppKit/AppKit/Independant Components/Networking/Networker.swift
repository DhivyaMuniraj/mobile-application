//
//  Networker.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation

public class Networker: NSObject {
	
	private let urlSession: URLSession
	private let jsonDecoder: JSONDecoder
	
	public init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
		
		self.urlSession = urlSession
		self.jsonDecoder = jsonDecoder
		
		super.init()
	}
	
	public func getDataTask(for urlRequestConvertable: URLRequestConvertable) -> URLSessionDataTask {
		
		let urlRequest = urlRequestConvertable.getRequest()
		
		let dataTask = self.urlSession.dataTask(with: urlRequest)
		
		return dataTask
	}
	
	public func executeDataTask< Success: Codable, Failure: Codable >(for urlRequestConvertable: URLRequestConvertable,
															   completion: @escaping ((Success?,
																					   Failure?,
																					   Data?,
																					   URLResponse?,
																					   Error?) -> ())) {
		let urlRequest = urlRequestConvertable.getRequest()
		
		self.urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
			
			if let data = data {
				
				let success: Success? = try? self?.jsonDecoder.decode(Success.self, from: data)
				let failure: Failure? = try? self?.jsonDecoder.decode(Failure.self, from: data)
				
				completion(success, failure, data, response, error)
				
			} else {
				
				completion(nil, nil, nil, response, error)
			}
		}
	}
}
