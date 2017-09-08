//
//  SceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

typealias CompletionFunction = (@escaping CompletionBlock) -> Void

protocol SceneOperation {
	func execute(with completion: CompletionBlock?)
}

extension SceneOperation {
	func then(_ operation: SceneOperation) -> SceneOperation {
		return OrderedSceneOperation(first: self, last: operation)
	}
}

class OrderedSceneOperation: SceneOperation {
	let first: SceneOperation
	let last: SceneOperation

	init(first: SceneOperation, last: SceneOperation) {
		self.first = first
		self.last = last
	}
}

extension OrderedSceneOperation {
	func execute(with completion: CompletionBlock?) {
		first.execute {
			self.last.execute {
				completion?()
			}
		}
	}
}
