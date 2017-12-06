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
	fileprivate let renderer: SceneOperationManager

	init(scene: Scene, renderer: SceneOperationManager) {
		self.scene = scene
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension ReloadSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)


		if scene.sceneHandler.name.value == visibleViewController.sceneName, scene.sceneHandler.isReloadable {
			scene.sceneHandler.reload(visibleViewController, parameters: scene.parameters)
		}

		completion?()
	}
}
