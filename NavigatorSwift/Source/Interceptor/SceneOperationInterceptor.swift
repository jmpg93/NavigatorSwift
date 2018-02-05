//
//  SceneOperationInterceptor.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol SceneOperationInterceptor: class {
	func operation(with operation: InterceptableSceneOperation) -> SceneOperation?
	func shouldIntercept(operation: InterceptableSceneOperation) -> Bool
}

// - MARK: Public methods

public extension SceneOperationInterceptor {
	func operation(with operation: InterceptableSceneOperation) -> SceneOperation? {
		return operation
	}

	func shouldIntercept(operation: InterceptableSceneOperation) -> Bool {
		return true
	}
}

// - MARK: Private methods

extension SceneOperationInterceptor {
	func execute(_ operation: InterceptableSceneOperation, with completion: CompletionBlock?) {
		if shouldIntercept(operation: operation) {
			if let operation = self.operation(with: operation) {
				operation.execute(with: completion)
			} else {
				completion?()
			}
		} else {
			operation.execute(with: completion)
		}
	}
}
