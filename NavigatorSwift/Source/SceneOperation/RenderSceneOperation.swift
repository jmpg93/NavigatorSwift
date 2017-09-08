//
//  RenderSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class RenderSceneOperation: SceneOperation {
	fileprivate let scenes: [Scene]
	fileprivate let visibleViewController: UIViewController

	init(scenes: [Scene], visibleViewController: UIViewController) {
		self.scenes = scenes
		self.visibleViewController = visibleViewController
	}
}

// MARK: SceneOperation methods

extension RenderSceneOperation {
	func execute(with completion: CompletionBlock?) {
		var currentVisibleViewController: UIViewController? = visibleViewController

		if let navigationController = visibleViewController as? UINavigationController {
			currentVisibleViewController = navigationController.viewControllers.first
		} else if let searchController = visibleViewController as? UISearchController {
			currentVisibleViewController = searchController.presentingViewController
		} else {
			currentVisibleViewController = visibleViewController
		}

		var navigationController: UINavigationController? = currentVisibleViewController?.navigationController

		for scene in scenes {
			let newViewController = scene.sceneHandler._buildViewController(with: scene.parameters)
			let animated = scene.isAnimated

			switch scene.type {
			case .push:
				navigationController?.pushViewController(newViewController, animated: animated)

			case .modalInsideNavigationBar:
				let navigationController = UINavigationController(rootViewController: newViewController)
				navigationController.modalPresentationStyle = newViewController.modalPresentationStyle
				navigationController.transitioningDelegate = newViewController.transitioningDelegate
				newViewController.transitioningDelegate = nil
				visibleViewController.present(navigationController, animated: animated, completion: completion)

			case .modal:
				visibleViewController.present(newViewController, animated: animated, completion: completion)
			}

			currentVisibleViewController = newViewController
			navigationController = currentVisibleViewController?.navigationController
		}
	}
}
