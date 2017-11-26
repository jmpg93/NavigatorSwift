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

		// Get the navigation controller the scene is refering to, if it matches.
		guard let rootNavigationController = firstLevelNavigationController(matching: scenes.first) else {
			completion?()
			return
		}

		// Move to the target root tab or navigation.
		renderer.setSelectedViewController(rootNavigationController)

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
			_next = self.next(from: next)
		}

		if let last = _last, let navigationController = last.navigationController {
			navigationController.popToViewController(last, animated: true)
		}

		if let last = _last, let presentedViewController = last.presentedViewController {
			presentedViewController.dismiss(animated: true, completion: nil)
		}

		renderer.add(scenes: scenesNotInStackYet).execute(with: completion)
	}

	///Returns true if the viewController can be handled by the scene and also is presented as require the scene, false otherwise.
	func isViewController(_ viewController: UIViewController, recyclableBy scene: Scene) -> Bool {
		let isManagedByScene = scene.sceneHandler.name.value == viewController.sceneName
		let isViewControllerRecyclable = scene.sceneHandler.isViewControllerRecyclable
		let isPresentedAsRequireScene = isViewController(viewController, presentedAsRequire: scene.type)

		return isManagedByScene && isPresentedAsRequireScene && isViewControllerRecyclable
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

	///Returns the next possible view controller that should be handle by the scene.
	func next(from viewcontroller: UIViewController) -> UIViewController? {
		// Search the view controllers of the navigation
		let viewControllers = viewcontroller.navigationController?.viewControllers
		// Get the next view controller after viewcontroller
		let nextNavigationIndex = viewControllers?.index(of: viewcontroller)?.advanced(by: 1)
		let navigationIndices = viewControllers?.indices

		// If navigationIndices contains the nextNavigationIndex, no view was presented. We keep the navigation controller hierarchy.
		if let nextNavigationIndex = nextNavigationIndex, navigationIndices?.contains(nextNavigationIndex) ?? false {
			return viewControllers?[nextNavigationIndex]
		}

		// If some UINavigationController was presented above an UINavigationController, we keep the navigation hierarchy.
		if let navigationController = viewcontroller.navigationController?.presentedViewController as? UINavigationController {
			return navigationController.viewControllers.first
		}

		// Some UIViewController was presented above an UINavigationController, we keep the modal hierarchy.
		if let presentedViewController = viewcontroller.navigationController?.presentedViewController {
			return presentedViewController
		}

		// Some UINavigationController was presented above an UIViewController, we keep the navigation hierarchy.
		if let navigationController = viewcontroller.presentedViewController as? UINavigationController {
			return navigationController.viewControllers.first
		}

		// Some UIViewController was presented above an UIViewController, we keep the modal hierarchy.
		if let presentedViewController = viewcontroller.presentedViewController {
			return presentedViewController
		}

		return nil
	}
}
