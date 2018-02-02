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
	fileprivate let manager: SceneOperationManager

	init(sceneName: SceneName, animated: Bool, manager: SceneOperationManager) {
		self.sceneName = sceneName
		self.animated = animated
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension DismissSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[DismissSceneOperation] Executing operation")

		let visibleViewController = self.visible(from: manager.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally && sceneName.value == visibleViewController.sceneName {
			logTrace("[DismissFirstSceneOperation] Dismissing scene \(String(describing: visibleViewController.sceneName))")
			visibleViewController.dismiss(animated: animated, completion: completion)
		} else {
			completion?()
		}
	}
}
