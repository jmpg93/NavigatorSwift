//
//  SceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol SceneOperation {
	func execute(with completion: CompletionBlock?)
	func then(_ operation: SceneOperation) -> SceneOperation
}
