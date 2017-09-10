//
//  DismissSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class DismissSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let scene: Scene
	fileprivate let animated: Bool
	fileprivate let renderer: SceneRenderer

	init(scene: Scene, animated: Bool, renderer: SceneRenderer) {
		self.scene = scene
		self.animated = animated
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension DismissSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally && scene.sceneHandler.name.value == visibleViewController.sceneName {
			visibleViewController.dismiss(animated: animated, completion: completion)
		}
	}
}
