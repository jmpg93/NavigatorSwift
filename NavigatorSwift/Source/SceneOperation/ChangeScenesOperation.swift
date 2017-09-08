//
//  ChangeScenesOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ChangeScenesOperation: SceneOperation {
	fileprivate var scenes: [Scene]
	fileprivate let sceneRendeded: SceneRenderer

	init(scenes: [Scene], sceneRendeded: SceneRenderer) {
		self.scenes = scenes
		self.sceneRendeded = sceneRendeded
	}
}

// MARK: SceneOperation methods

extension ChangeScenesOperation {
	func execute(with completion: CompletionBlock?) {
		guard !scenes.isEmpty else { return }
		let firstScene = scenes.removeFirst()

		let dismissOperation = DismisAllViewControllerOperation(rootViewController: sceneRendeded.rootViewController, animated: false)
		let installOperation = InstallSceneOperation(scene: firstScene, renderer: sceneRendeded)
		let recycleOperation = RecycleSceneOperation(scenes: scenes, renderer: sceneRendeded)

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

extension ChangeScenesOperation {
	/// Returns true if the rootViewController in Window is handled by the scene
	func isRootViewController(matching scene: Scene) -> Bool {
		var isEqual: Bool = false

		if let rootViewController = sceneRendeded.rootViewController as? UINavigationController {
			isEqual = rootViewController.viewControllers.first?.sceneName == scene.sceneHandler.name.value
		}

		return isEqual
	}
}
