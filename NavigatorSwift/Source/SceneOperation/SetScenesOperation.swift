//
//  SetScenesOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class SetScenesOperation: SceneOperation {
	fileprivate var scenes: [Scene]
	fileprivate let renderer: SceneRenderer

	init(scenes: [Scene], renderer: SceneRenderer) {
		self.scenes = scenes
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension SetScenesOperation {
	func execute(with completion: CompletionBlock?) {
		guard !scenes.isEmpty else { return }
		let firstScene = scenes.removeFirst()

		let dismissOperation = renderer.dismissAll(animated: false)
		let installOperation = renderer.install(scene: firstScene)
		let recycleOperation = renderer.recycle(scenes: scenes)

		if isRootViewController(matching: firstScene) {
			dismissOperation
				.then(recycleOperation)
				.execute(with: completion)
		} else {
			dismissOperation
				.then(installOperation)
				.then(recycleOperation)
				.execute(with: completion)
		}
	}
}

// MARK: Private methods

extension SetScenesOperation {
	/// Returns true if the rootViewController in Window is handled by the scene
	func isRootViewController(matching scene: Scene) -> Bool {
		var isEqual: Bool = false

		if let rootViewController = renderer.rootViewController as? UINavigationController {
			isEqual = rootViewController.viewControllers.first?.sceneName == scene.sceneHandler.name.value
		}

		return isEqual
	}
}
