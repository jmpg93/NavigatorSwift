//
//  RecycleSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

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
		guard !scenes.isEmpty else {
			completion?()
			return
		}

		// Get the navigation controller the scene is refering to, if it matches.
		guard let rootNavigationController = firstLevelNavigationController(matching: scenes.first) else {
			completion?()
			return
		}

		// Move to the target root tab or navigation.
		manager.setSelectedViewController(rootNavigationController)

		// Get the first view controller of the stack.
		var _next = rootNavigationController.viewControllers.first
		var _last = _next

		var scenesNotInStackYet = scenes

		for scene in scenes {
			guard let next = _next else { break }
			guard isViewController(next, recyclableBy: scene) else { break }

			scene.sceneHandler.reload(next, parameters: scene.parameters)
			scenesNotInStackYet.removeFirst()

			_last = next
			_next = self.next(before: next)
		}

		guard let last = _last else { fatalError("No root view controller found") }

		let addSceneOperation = manager.add(scenes: scenesNotInStackYet)
		let setVisibleOperation = manager.setVisible(viewController: last)

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
		switch type {
		case .push:
			return viewController.navigationController != nil

		case .modal:
			return viewController.presentingViewController != nil

		case .modalNavigation:
			return viewController.navigationController != nil
				&& viewController.navigationController?.presentingViewController != nil
			
		case .reload, .root:
			return true
		}
	}
}

private extension RecycleSceneOperation {
	func firstLevelNavigationController(matching scene: Scene?) -> UINavigationController? {
		guard let scene = scene else { return nil }
		return viewControllerContainer.firstLevelNavigationController(matching: scene)
	}
}
