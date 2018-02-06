//
//  PopOverSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 20/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct PopoverSceneOperation {
	private let popover: Popover
	private let scene: Scene
	private let manager: SceneOperationManager

	init(popover: Popover, to scene: Scene, manager: SceneOperationManager) {
		self.popover = popover
		self.scene = scene
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension PopoverSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[PopSceneOperation] Executing operation")
		scene.operationParameters[ParametersKeys.popover] = popover
		manager.add(scenes: [scene]).execute(with: completion)
	}

	func context(from: [SceneState]) -> SceneOperationContext {
		return SceneOperationContext(currentState: from, targetState: from.appending(scene))
	}
}
