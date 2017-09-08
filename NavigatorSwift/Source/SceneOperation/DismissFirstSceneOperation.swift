//
//  DismissFirstSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class DismissFirstSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let visibleNavigationController: UINavigationController
	fileprivate let animated: Bool

	init(visibleNavigationController: UINavigationController, animated: Bool) {
		self.visibleNavigationController = visibleNavigationController
		self.animated = animated
	}
}

// MARK: SceneOperation methods

extension DismissFirstSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let visibleViewController = self.visibleViewController(from: visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally {
			visibleViewController.dismiss(animated: animated, completion: completion)
		}
	}
}
