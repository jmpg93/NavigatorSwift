//
//  DismissSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct DismissSceneOperation {
	private let sceneName: SceneName
	private let animated: Bool
	private let manager: SceneOperationManager

	init(sceneName: SceneName, animated: Bool, manager: SceneOperationManager) {
		self.sceneName = sceneName
		self.animated = animated
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension DismissSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[DismissSceneOperation] Executing operation")

		guard let visibleNavigationController = manager.visibleNavigationController else {
			logTrace("[DismissSceneOperation] No visible navigation controller found")
			completion?()
			return
		}

		let visibleViewController = manager.visible(from: visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally && sceneName.value == visibleViewController.sceneName {
			logTrace("[DismissFirstSceneOperation] Dismissing scene \(String(describing: visibleViewController.sceneName))")
			visibleViewController.dismiss(animated: animated, completion: completion)
		} else {
			completion?()
		}
	}

	func context(from: [SceneState]) -> SceneOperationContext {
		return SceneOperationContext(currentState: from, targetState: from.dropping(from: .modal))
	}
}
