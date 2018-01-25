//
//  AddSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

struct AddSceneOperation {
	fileprivate let scenes: [Scene]
	fileprivate let manager: SceneOperationManager

	init(scenes: [Scene], manager: SceneOperationManager) {
		self.scenes = scenes
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension AddSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		guard !scenes.isEmpty else {
			completion?()
			return
		}
		
		let visibleViewController = manager.visibleViewController(from: manager.rootViewController)
		recursiveShow(scenes: scenes, visibleViewController: visibleViewController, completion: completion)
	}
}

private extension AddSceneOperation {
	func recursiveShow(scenes: [Scene], visibleViewController: UIViewController?, completion: CompletionBlock?) {
		guard !scenes.isEmpty else {
			completion?()
			return
		}

		var scenes = scenes
		let scene = scenes.removeFirst()

		let newViewController = scene.view()
		let animated = scene.isAnimated

		let recursiveCall: CompletionBlock =  {
			self.recursiveShow(scenes: scenes, visibleViewController: newViewController, completion: completion)
		}

		switch scene.type {
		case .push:
			self.push(from: visibleViewController?.navigationController, newViewController, animated: animated, completion: recursiveCall)

		case .modalNavigation:
			self.presentWithNavigation(from: visibleViewController, newViewController, animated: animated, completion: recursiveCall)

		case .modal:
			self.present(from: visibleViewController, newViewController, animated: animated, completion: recursiveCall)

		case .root:
			self.root(scene: scene, completion: recursiveCall)

		case .none:
			recursiveCall()
		}
	}
}

private extension AddSceneOperation {
	func present(from: UIViewController?, _ viewController: UIViewController, animated: Bool, completion: @escaping CompletionBlock) {
		guard let from = from else {
			completion()
			return
		}

		from.present(viewController, animated: animated, completion: completion)
	}

	func presentWithNavigation(from: UIViewController?, _ viewController: UIViewController, animated: Bool, completion: @escaping CompletionBlock) {
		guard let from = from else {
			completion()
			return
		}

		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.modalPresentationStyle = viewController.modalPresentationStyle
		navigationController.transitioningDelegate = viewController.transitioningDelegate
		viewController.transitioningDelegate = nil

		present(from: from, navigationController, animated: animated, completion: completion)
	}

	func push(from: UINavigationController?, _ viewController: UIViewController, animated: Bool, completion: @escaping CompletionBlock) {
		guard let from = from else {
			completion()
			return
		}

		CATransaction.begin()
		from.pushViewController(viewController, animated: animated)
		CATransaction.setCompletionBlock(completion)
		CATransaction.commit()
	}

	func root(scene: Scene, completion: @escaping CompletionBlock) {
		self.manager.root(scene: scene).execute(with: completion)
	}
}
