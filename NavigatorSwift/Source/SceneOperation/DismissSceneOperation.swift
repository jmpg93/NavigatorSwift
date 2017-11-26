//
//  DismissSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class DismissSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let sceneName: SceneName
	fileprivate let animated: Bool
	fileprivate let renderer: SceneRenderer

	init(sceneName: SceneName, animated: Bool, renderer: SceneRenderer) {
		self.sceneName = sceneName
		self.animated = animated
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension DismissSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally && sceneName.value == visibleViewController.sceneName {
			visibleViewController.dismiss(animated: animated, completion: completion)
		}
	}
}
