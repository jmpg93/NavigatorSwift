//
//  DismissFirstSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct DismissFirstSceneOperation: VisibleViewControllerFindable {
	fileprivate let animated: Bool
	fileprivate let renderer: SceneOperationManager

	init(animated: Bool, renderer: SceneOperationManager) {
		self.animated = animated
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension DismissFirstSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally {
			visibleViewController.dismiss(animated: animated, completion: completion)
		} else {
			completion?()
		}
	}
}
