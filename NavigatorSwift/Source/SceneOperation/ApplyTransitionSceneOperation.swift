//
//  ApplyTransitionSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct ApplyTransitionSceneOperation: VisibleViewControllerFindable {
	fileprivate let transition: Transition
	fileprivate let scene: Scene
	fileprivate let renderer: SceneOperationManager

	init(transition: Transition, to scene: Scene, renderer: SceneOperationManager) {
		self.transition = transition
		self.scene = scene
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension ApplyTransitionSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		scene.operationParameters[ParametersKeys.transition] = transition
		renderer.add(scenes: [scene]).execute(with: completion)
	}
}

