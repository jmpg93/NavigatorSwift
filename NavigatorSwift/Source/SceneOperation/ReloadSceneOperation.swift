//
//  ReloadSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 26/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ReloadSceneOperation: VisibleViewControllerFindable {
	fileprivate let scene: Scene
	fileprivate let manager: SceneOperationManager

	init(scene: Scene, manager: SceneOperationManager) {
		self.scene = scene
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension ReloadSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[ReloadSceneOperation] Executing operation")

		let visibleViewController = self.visible(from: manager.visibleNavigationController)

		if scene.sceneHandler.name.value == visibleViewController.sceneName, scene.sceneHandler.isReloadable {
			scene.sceneHandler.reload(visibleViewController, parameters: scene.parameters)
		}

		completion?()
	}
}
