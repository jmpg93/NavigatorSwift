//
//  DismissFirstSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class DismissFirstSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let animated: Bool
	fileprivate let renderer: SceneRenderer

	init(animated: Bool, renderer: SceneRenderer) {
		self.animated = animated
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension DismissFirstSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: renderer.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally {
			visibleViewController.dismiss(animated: animated, completion: completion)
		} else {
			completion?()
		}
	}
}
