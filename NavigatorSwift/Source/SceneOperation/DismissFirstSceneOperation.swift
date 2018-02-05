//
//  DismissFirstSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct DismissFirstSceneOperation {
	private let animated: Bool
	private let manager: SceneOperationManager

	init(animated: Bool, manager: SceneOperationManager) {
		self.animated = animated
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension DismissFirstSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[DismissFirstSceneOperation] Executing operation")

		guard let visibleNavigationController = manager.visibleNavigationController else {
			logTrace("[DismissAllOperation] No visible navigation controller found")
			completion?()
			return
		}

		let visibleViewController = manager.visible(from: visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally {
			logTrace("[DismissFirstSceneOperation] Dismissing scene \(String(describing: visibleViewController.sceneName))")
			visibleViewController.dismiss(animated: animated, completion: completion)
		} else {
			logTrace("[DismissFirstSceneOperation] Could not dismiss first viewController")
			completion?()
		}
	}

	func context() -> SceneOperationContext {
		let from = manager.state(from: manager.rootViewController)
		let to = from.dropping(first: .modal)

		return SceneOperationContext(from: from, to: to)
	}
}
