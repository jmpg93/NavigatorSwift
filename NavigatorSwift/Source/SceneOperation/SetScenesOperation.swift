//
//  SetScenesOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

struct SetScenesOperation {
	fileprivate var scenes: [Scene]
	fileprivate let manager: SceneOperationManager

	init(scenes: [Scene], manager: SceneOperationManager) {
		self.scenes = scenes
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension SetScenesOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[SetScenesOperation] Executing operation")
		guard let rootScene = scenes.first else {
			logTrace("[SetScenesOperation] No scenes to set")
			completion?()
			return
		}
		
		if isRootViewController(matching: rootScene) {
			logTrace("[SetScenesOperation] Stack can be recycled")
			manager
				.recycle(scenes: scenes)
				.execute(with: completion)
		} else {
			logTrace("[SetScenesOperation] Stack can't be recycled")
			manager
				.dismissAll(animated: false)
				.then(manager.add(scenes: scenes))
				.execute(with: completion)
		}
	}
}

// MARK: Private methods

extension SetScenesOperation {
	/// Returns true if the rootViewController in Window is handled by the scene
	func isRootViewController(matching scene: Scene) -> Bool {
		return manager.rootViewController.sceneName == scene.sceneHandler.name.value
	}
}
