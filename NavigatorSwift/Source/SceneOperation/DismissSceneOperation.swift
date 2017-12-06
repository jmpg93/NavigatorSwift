//
//  DismissSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct DismissSceneOperation: VisibleViewControllerFindable {
	fileprivate let sceneName: SceneName
	fileprivate let animated: Bool
	fileprivate let renderer: SceneOperationManager

	init(sceneName: SceneName, animated: Bool, renderer: SceneOperationManager) {
		self.sceneName = sceneName
		self.animated = animated
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension DismissSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally && sceneName.value == visibleViewController.sceneName {
			visibleViewController.dismiss(animated: animated, completion: completion)
		} else {
			completion?()
		}
	}
}
