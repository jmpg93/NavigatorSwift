//
//  SceneOperation+Utils.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 6/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public extension SceneOperation {
	func then(_ operation: SceneOperation) -> SceneOperation {
		return OrderedSceneOperation(first: self, last: operation)
	}
}
