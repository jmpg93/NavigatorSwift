//
//  EmptySceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 6/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct EmptySceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		completion?()
	}
}
