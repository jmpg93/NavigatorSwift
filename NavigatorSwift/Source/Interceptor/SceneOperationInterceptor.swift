//
//  SceneOperationInterceptor.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol SceneOperationInterceptor: class {
	func operation(for operation: SceneOperation, with context: SceneOperationContext) -> SceneOperation?
	func shouldIntercept(_ operation: SceneOperation, with context: SceneOperationContext) -> Bool
}

// MARK: Public methods

public extension SceneOperationInterceptor {
	func operation(for operation: SceneOperation, with context: SceneOperationContext) -> SceneOperation? {
		return operation
	}

	func shouldIntercept(_ operation: SceneOperation, with context: SceneOperationContext) -> Bool {
		return false
	}
}
