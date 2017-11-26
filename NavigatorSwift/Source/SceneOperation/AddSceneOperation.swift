//
//  AddSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class AddSceneOperation: SceneOperation {
	fileprivate let scenes: [Scene]
	fileprivate let renderer: SceneRenderer

	init(scenes: [Scene], renderer: SceneRenderer) {
		self.scenes = scenes
		self.renderer = renderer
	}
}

// MARK: SceneOperation methods

extension AddSceneOperation {
	func execute(with completion: CompletionBlock?) {
		guard !scenes.isEmpty else { return }
		
		let visibleViewController = renderer.visibleViewController(from: renderer.rootViewController)
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
			let newViewController = scene.buildViewController()
			let animated = scene.isAnimated

			switch scene.type {
			case .push:
				navigationController?.pushViewController(newViewController, animated: animated)

			case .modalNavigation:
				let navigationController = UINavigationController(rootViewController: newViewController)
				navigationController.modalPresentationStyle = newViewController.modalPresentationStyle
				navigationController.transitioningDelegate = newViewController.transitioningDelegate
				newViewController.transitioningDelegate = nil
				visibleViewController.present(navigationController, animated: animated, completion: completion)

			case .modal:
				visibleViewController.present(newViewController, animated: animated, completion: completion)

			case .reload:
				continue
			}

			currentVisibleViewController = newViewController
			navigationController = currentVisibleViewController?.navigationController
		}
	}
}
