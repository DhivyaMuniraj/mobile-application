//
//  URLRequestConvertable.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation

public enum HTTPMethod: String, CaseIterable {
	case POST = "POST"
	case GET = "GET"
	case PUT = "PUT"
	case PATCH = "PATCH"
	case DELETE = "DELETE"
}



public protocol URLRequestConvertable {
	func getRequest() -> URLRequest
}

public protocol RequestObject: URLRequestConvertable {
	var httpMethod: HTTPMethod { get set }
	
	var baseURL: String { get set }
	var path: String { get set }
	var querryItems: [(String, String)] { get set }
	var bodyData: Data? { get set }
	
	var stubResponse: String { get set }
}
