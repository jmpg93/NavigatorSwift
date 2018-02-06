//
//  Interceptor.swift
//  NavigatorSwiftDemo
//
//  Created by Jose Maria Puerta on 5/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift

class Interceptor: SceneOperationInterceptor {
	static let shared = Interceptor()
	
	func operation(with operation: SceneOperation, context: SceneOperationContext) -> SceneOperation? {
		let toContextName = context.to.map({ $0.name })
		print("\(type(of: operation)) with final context \(toContextName)")

		return operation
	}

	func shouldIntercept(operation: SceneOperation, context: SceneOperationContext) -> Bool {
		return true
	}
}
