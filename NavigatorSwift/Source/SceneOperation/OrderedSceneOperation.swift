//
//  OrderedSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct OrderedSceneOperation: SceneOperation {
	let first: SceneOperation
	let last: SceneOperation

	init(first: SceneOperation, last: SceneOperation) {
		self.first = first
		self.last = last
	}
}

// MARK: SceneOperation methods

extension OrderedSceneOperation {
	func execute(with completion: CompletionBlock?) {
		first.execute {
			self.last.execute {
				completion?()
			}
		}
	}
}
