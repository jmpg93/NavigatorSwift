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
		guard let viewControllerContainer = scene.view() as? ViewControllerContainer else {
			completion?()
			return
		}

		if !manager.viewControllerContainer.canBeReuse(by: viewControllerContainer) {
			manager.viewControllerContainer = viewControllerContainer
		}

		manager.window.rootViewController = manager.rootViewController
		manager.window.makeKeyAndVisible()

		completion?()
	}
}
