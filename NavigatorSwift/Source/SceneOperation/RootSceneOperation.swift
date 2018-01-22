//
//  RootSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class RootSceneOperation {
	fileprivate let scene: Scene
	fileprivate let manager: SceneOperationManager

	init(scene: Scene, manager: SceneOperationManager) {
		self.scene = scene
		self.manager = manager
	}
}

extension RootSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		let buildedViewController = scene.view()

		if let buildedViewController = buildedViewController as? ViewControllerContainer {
			manager.viewControllerContainer = buildedViewController
		} else {
			let navigationBarContainer = NavigationBarContainer()
			manager.viewControllerContainer = navigationBarContainer

			let navigationController = navigationBarContainer.visibleNavigationController
			navigationController.pushViewController(buildedViewController, animated: false)
		}

		manager.window.rootViewController = manager.rootViewController
		manager.window.makeKeyAndVisible()

		completion?()
	}
}
