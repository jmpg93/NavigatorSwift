//
//  ApplyTransitionSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct ApplyTransitionSceneOperation {
	private let transition: Transition
	private let scene: Scene
	private let manager: SceneOperationManager

	init(transition: Transition, to scene: Scene, manager: SceneOperationManager) {
		self.transition = transition
		self.scene = scene
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension ApplyTransitionSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[AddSceneOperation] Executing operation")
		scene.operationParameters[ParametersKeys.transition] = transition
		manager.add(scenes: [scene]).execute(with: completion)
	}

	func context(from: [SceneState]) -> SceneOperationContext {
		return SceneOperationContext(currentState: from, targetState: from.appending(scene))
	}
}
