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

	fileprivate var viewControllerContainer: ViewControllerContainer {
		return manager.viewControllerContainer
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

		// Get the root scene
		var scenes = self.scenes
		let rootScene = scenes.removeFirst()

		// Checked that the root is matching the scene
		guard manager.rootViewController.sceneName == rootScene.sceneHandler.name.value else {
			logTrace("[RecycleSceneOperation] No root scene matching current root viewViewController")
			completion?()
			return
		}

		// Reload the rootViewController
		logTrace("[RecycleSceneOperation] Reloading root scene")
		rootScene.sceneHandler.reload(manager.rootViewController, parameters: rootScene.parameters)

		// Get the navigation controller the scene is refering to, if it matches.
		guard let rootNavigationController = firstLevelNavigationController(matching: scenes.first) else {
			logTrace("[RecycleSceneOperation] Found first level navigation controller matching scene \(String(describing: scenes.first?.sceneHandler.name))")
			completion?()
			return
		}

		// Move to the target root tab or navigation.
		logTrace("[RecycleSceneOperation] Selecting scene \(String(describing: scenes.first?.sceneHandler.name))")
		manager.select(viewController: rootNavigationController)

		// Get the first view controller of the stack.
		var _next = rootNavigationController.viewControllers.first
		var _last = _next

		var scenesNotInStackYet = scenes

		for scene in scenes {
			guard let next = _next else { break }
			guard isViewController(next, recyclableBy: scene) else { break }

			logTrace("[RecycleSceneOperation] Reloading scene \(scene)")
			scene.sceneHandler.reload(next, parameters: scene.parameters)
			scenesNotInStackYet.removeFirst()

			_last = next
			_next = self.next(before: next)
		}

		guard let last = _last else { fatalError("No root view controller found") }

		logTrace("[RecycleSceneOperation] \(scenesNotInStackYet.count) scenes (\(scenesNotInStackYet.map({ $0.sceneHandler.name }))) could not be recycled with the current stack")
		let setVisibleOperation = manager.setVisible(viewController: last)
		let addSceneOperation = manager.add(scenes: scenesNotInStackYet)

		setVisibleOperation
			.then(addSceneOperation)
			.execute(with: completion)
	}

	///Returns true if the viewController can be handled by the scene and also is presented as require the scene, false otherwise.
	func isViewController(_ viewController: UIViewController, recyclableBy scene: Scene) -> Bool {
		let isManagedByScene = scene.sceneHandler.name.value == viewController.sceneName
		let isReloadable = scene.sceneHandler.isReloadable
		let isPresentedAsRequireScene = isViewController(viewController, presentedAsRequire: scene.type)

		return isManagedByScene && isPresentedAsRequireScene && isReloadable
	}

	///Returns true if the viewController presented as require the ScenePresentationType (by checking the hierarchy of the viewController), false otherwise.
	func isViewController(_ viewController: UIViewController, presentedAsRequire type: ScenePresentationType) -> Bool {
		switch (type, viewController.scenePresentationType) {
		case (.push, .push),
			 (.modal, .modal),
			 (.modalNavigation, .modalNavigation),
			 (.root, .root),
			 (_, .none),
			 (.none, _):
			return true
		default:
			return false
		}
	}
}

private extension RecycleSceneOperation {
	func firstLevelNavigationController(matching scene: Scene?) -> UINavigationController? {
		guard let scene = scene else { return nil }
		return viewControllerContainer.firstLevelNavigationController(matching: scene)
	}
}
