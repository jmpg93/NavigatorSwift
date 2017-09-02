//
//  NavigationRequestProvider.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol NavigationRequestProvider {
	func navigationRequest(using builderBlock: NavigationRequestBuilderBlock) -> NavigationRequest
}

public class DefaultNavigationRequestProvider: NavigationRequestProvider {
	public init() { }
	
	public func navigationRequest(using builderBlock: (NavigationRequestBuilder) -> Void) -> NavigationRequest {
		return NavigationRequest(using: builderBlock)
	}
}
