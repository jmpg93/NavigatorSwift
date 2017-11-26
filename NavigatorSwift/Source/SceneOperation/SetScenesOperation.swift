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
		guard let rootScene = scenes.first else {
			completion?()
			return
		}
		
		if isRootViewController(matching: rootScene) {
			renderer
				.recycle(scenes: scenes)
				.execute(with: completion)
		} else {
			renderer
				.dismissAll(animated: false)
				.then(renderer.add(scenes: scenes))
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
