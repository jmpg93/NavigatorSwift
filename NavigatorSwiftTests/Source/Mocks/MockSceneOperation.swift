//
//  MockOperation.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
@testable import NavigatorSwift

class MockSceneOperation: SceneOperation {
	var executed = false

	func execute(with completion: CompletionBlock?) {
		executed = true
		completion?()
	}

	func then(_ operation: SceneOperation) -> SceneOperation {
		return OrderedSceneOperation(first: self, last: operation)
	}
}
