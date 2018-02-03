//
//  RootSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class RootSceneOperation {
	private let scene: Scene
	private let manager: SceneOperationManager

	init(scene: Scene, manager: SceneOperationManager) {
		self.scene = scene
		self.manager = manager
	}
}

extension RootSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[RootSceneOperation] Executing operation")

		guard let viewControllerContainer = scene.view() as? ViewControllerContainer else {
			logError("[RootSceneOperation] View builded from \(scene) is not a ViewControllerContainer")
			completion?()
			return
		}

		if !manager.canReused(container: viewControllerContainer) {
			logDebug("[RootSceneOperation] Current ViewControllerContainer can't be reused for scene \(scene)")
			manager.set(container: viewControllerContainer)
		} else {
			logDebug("[RootSceneOperation] Current ViewControllerContainer will be reused for scene \(scene)")
		}

		completion?()
	}
}
