//
//  RecycleSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class RecycleSceneOperation: SceneOperation {
	fileprivate let scenes: [Scene]
	fileprivate let renderer: SceneRenderer

	init(scenes: [Scene], renderer: SceneRenderer) {
		self.scenes = scenes
		self.renderer = renderer
	}

	fileprivate var viewControllerContainer: ViewControllerContainer {
		return renderer.viewControllerContainer
	}
}

// MARK: SceneOperation methods

extension RecycleSceneOperation {
	func execute(with completion: CompletionBlock?) {
		guard !scenes.isEmpty else {
			completion?()
			return
		}

		// Get the navigation controller the scene is refering to.
		guard let navigationControllerToRecycle = firstLevelNavigationController(matching: scenes.first) else {
			completion?()
			return
		}

		// Move to the target root tab or navigation
		renderer.setSelectedViewController(navigationControllerToRecycle)

		var _next = navigationControllerToRecycle.viewControllers.first
		var scenesNotInStackYet = scenes

		for scene in scenes {
			guard let next = _next else { break }
			guard isViewController(next, recyclableBy: scene) else { break }

			scene.sceneHandler.reload(next, parameters: scene.parameters)
			scenesNotInStackYet.removeFirst()

			_next = self.next(from: next)
		}

		if let viewController = _next {
			if navigationControllerToRecycle.viewControllers.contains(viewController) {
				navigationControllerToRecycle.popToViewController(viewController, animated: true)
			}
			viewController.dismiss(animated: true, completion: nil)
		}

		renderer.add(scenes: scenesNotInStackYet).execute(with: completion)
	}

	///Returns Yes if the viewController is handled by the scene and also is presented as require the scene, NO otherwise.
	func isViewController(_ viewController: UIViewController, recyclableBy scene: Scene) -> Bool {
		let isManagedByScene = scene.sceneHandler.name.value == viewController.sceneName
		let isViewControllerRecyclable = scene.sceneHandler.isViewControllerRecyclable
		let isPresentedAsRequireScene = isViewController(viewController, presentedAsRequire: scene.type)

		return isManagedByScene && isPresentedAsRequireScene && isViewControllerRecyclable
	}

	func isViewController(_ viewController: UIViewController, presentedAsRequire type: ScenePresentationType) -> Bool {
		switch type {
		case .push:
			return viewController.navigationController != nil

		case .modal:
			return viewController.presentingViewController != nil

		case .modalNavigation:
			return viewController.navigationController != nil
				&& viewController.navigationController?.presentingViewController != nil
			
		case .reload:
			return true
		}
	}
}

private extension RecycleSceneOperation {
	func firstLevelNavigationController(matching scene: Scene?) -> UINavigationController? {
		guard let scene = scene else { return nil }
		return viewControllerContainer.firstLevelNavigationController(matching: scene)
	}

	func next(from viewcontroller: UIViewController) -> UIViewController? {
		let viewControllers = viewcontroller.navigationController?.viewControllers
		let nextNavigationIndex = viewControllers?.index(of: viewcontroller)?.advanced(by: 1)
		let navigationIndices = viewControllers?.indices

		if let nextNavigationIndex = nextNavigationIndex, navigationIndices?.contains(nextNavigationIndex) ?? false {
			return viewControllers?[nextNavigationIndex]
		} else if let modal = viewcontroller.navigationController?.presentedViewController {
			return modal
		} else if let modal = viewcontroller.presentedViewController {
			return modal
		} else {
			return nil
		}
	}
}
