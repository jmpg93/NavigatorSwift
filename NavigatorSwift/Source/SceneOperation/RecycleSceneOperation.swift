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
		guard !scenes.isEmpty else { return }

		var scenesNotInStackYet = scenes

		guard let firstSceneNotInStack = scenesNotInStackYet.first else { return }

		// Move to the target root tab or navigation
		guard let navigationControllerToRecycle = viewControllerContainer.firstLevelNavigationController(matching: firstSceneNotInStack) else { return }
		renderer.setSelectedViewController(navigationControllerToRecycle)

		//TODO: Fix this
		var finalViewControllers: [UIViewController] = []
		for (_, viewControllerToRecycle) in navigationControllerToRecycle.viewControllers.enumerated() {
			let searchingScene = scenesNotInStackYet.first!

			if isViewController(viewControllerToRecycle, recyclableBy: searchingScene) {
				finalViewControllers.append(viewControllerToRecycle)
				searchingScene.sceneHandler.reload(viewControllerToRecycle, parameters: searchingScene.parameters)
				scenesNotInStackYet.remove(at: 0)
			} else {

			}
		}

		// Finaly add scenes not in stack yet.
		if let visibleViewController = navigationControllerToRecycle.visibleViewController {
			RenderSceneOperation(scenes: scenesNotInStackYet, visibleViewController: visibleViewController).execute(with: completion)
		}
	}
}

// MARK: Private methods

private extension RecycleSceneOperation {
	///Returns Yes if the viewController is handled by the scene and also is presented as require the scene, NO otherwise.
	func isViewController(_ viewController: UIViewController, recyclableBy scene: Scene) -> Bool {
		let isManagedByScene = scene.sceneHandler.name.value == viewController.sceneName
		let isPresentedAsRequireScene = isViewController(viewController, presentedAsRequire: scene)
		let isViewControllerRecyclable = scene.sceneHandler.isViewControllerRecyclable

		return isManagedByScene && isPresentedAsRequireScene && isViewControllerRecyclable
	}


	func isViewController(_ viewController: UIViewController, presentedAsRequire scene: Scene) -> Bool {

		switch scene.type {
		case .push:
			return viewController.navigationController != nil

		case .modal:
			return viewController.presentingViewController != nil

		case .modalInsideNavigationBar:
			return viewController.navigationController != nil
				&& viewController.navigationController?.presentingViewController != nil
		}
	}
}
