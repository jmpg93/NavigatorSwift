//
//  ReloadSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 26/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ReloadSceneOperation {
	private let scene: Scene
	private let manager: SceneOperationManager

	init(scene: Scene, manager: SceneOperationManager) {
		self.scene = scene
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension ReloadSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[ReloadSceneOperation] Executing operation")

		guard let visibleNavigationController = manager.visibleNavigationController else {
			logTrace("[ReloadSceneOperation] No visible navigation controller found")
			completion?()
			return
		}

		let visibleViewController = manager.visible(from: visibleNavigationController)

		if scene.sceneHandler.name.value == visibleViewController.sceneName, scene.sceneHandler.isReloadable {
			scene.sceneHandler.reload(visibleViewController, parameters: scene.parameters)
		}

		completion?()
	}

	func context() -> SceneOperationContext {
		let from = manager.state(from: manager.rootViewController)

		return SceneOperationContext(from: from, to: from)
	}
}
