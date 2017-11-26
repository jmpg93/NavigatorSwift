//
//  ReloadSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 26/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ReloadSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let scene: Scene
	fileprivate let renderer: SceneRenderer

	init(scene: Scene, renderer: SceneRenderer) {
		self.scene = scene
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension ReloadSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)

		if scene.sceneHandler.name.value == visibleViewController.sceneName {
			scene.sceneHandler.reload(visibleViewController, parameters: scene.parameters)
			completion?()
		}
	}
}
