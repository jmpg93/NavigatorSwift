//
//  RecycleSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

struct RecycleSceneOperation: NextViewControllerFindable {
	fileprivate let scenes: [Scene]
	fileprivate let manager: SceneOperationManager

	init(scenes: [Scene], manager: SceneOperationManager) {
		self.scenes = scenes
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension RecycleSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[RecycleSceneOperation] Executing operation")

		guard !self.scenes.isEmpty else {
			logTrace("[RecycleSceneOperation] No scenes to recycle")
			completion?()
			return
		}

		// Scenes not in stack 
		var scenes = self.scenes

		var _next: UIViewController? = manager.rootViewController
		var _last = _next

		for scene in scenes {
			guard let next = _next, next.isRecyclable(by: scene) else { break }

			logTrace("[RecycleSceneOperation] Selecting first level navigation controller with scene \(scene.sceneHandler.name)")
			if let first = firstLevelNavigationController(matching: scene) {
				manager.select(viewController: first)
			}
			
			logTrace("[RecycleSceneOperation] Reloading scene \(scene)")
			scene.sceneHandler.reload(next, parameters: scene.parameters)
			scenes.removeFirst()

			_last = next
			_next = self.next(before: next)
		}

		guard let last = _last else { fatalError("No root view controller found") }

		logTrace("[RecycleSceneOperation] \(scenes.count) scenes (\(scenes.map({ $0.sceneHandler.name }))) could not be recycled with the current stack")

		let setVisibleOperation = manager.setVisible(viewController: last)
		let addSceneOperation = manager.add(scenes: scenes)

		setVisibleOperation
			.then(addSceneOperation)
			.execute(with: completion)
	}
}

private extension RecycleSceneOperation {
	func firstLevelNavigationController(matching scene: Scene?) -> UINavigationController? {
		guard let scene = scene else { return nil }
		return manager.firstLevelNavigationController(matching: scene)
	}
}
