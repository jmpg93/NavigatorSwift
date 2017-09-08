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
	fileprivate let visibleNavigationController: UINavigationController
	fileprivate let animated: Bool

	init(scene: Scene, visibleNavigationController: UINavigationController, animated: Bool) {
		self.scene = scene
		self.visibleNavigationController = visibleNavigationController
		self.animated = animated
	}
}

// MARK: SceneOperation methods

extension DismissSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally && scene.sceneHandler.name.value == visibleViewController.sceneName {
			visibleViewController.dismiss(animated: animated, completion: completion)
		}
	}
}
