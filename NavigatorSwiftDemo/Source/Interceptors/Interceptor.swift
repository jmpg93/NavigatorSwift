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
		print("\(type(of: operation)) with final context \(context.targetState.names)")
		return operation
	}
}
