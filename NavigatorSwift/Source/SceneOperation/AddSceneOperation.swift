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

extension AddSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[AddSceneOperation] Executing operation")

		guard !scenes.isEmpty else {
			logTrace("[AddSceneOperation] No scenes to add")
			completion?()
			return
		}

		let visibleViewController: UIViewController?

		if let rootViewController = manager.rootViewController {
			visibleViewController = manager.visible(from: rootViewController)
		} else {
			visibleViewController = nil
		}

		recursiveShow(scenes: scenes, visibleViewController: visibleViewController, completion: completion)
	}

	func context() -> InterceptorContext {
		let from = manager.state(from: manager.rootViewController)
		let to = scenes.map(ScenePresentationState.init)

		return InterceptorContext(from: from, to: to)
	}
}

// MARK: Recursion methods

private extension AddSceneOperation {
	func recursiveShow(scenes: [Scene], visibleViewController: UIViewController?, completion: CompletionBlock?) {
		guard !scenes.isEmpty else {
			completion?()
			return
		}

		var scenes = scenes
		let scene = scenes.removeFirst()

		let newViewController = scene.view()
		let recursiveCall: CompletionBlock = {
			self.recursiveShow(scenes: scenes, visibleViewController: newViewController, completion: completion)
		}

		switch scene.type {
		case .push:
			logTrace("[AddSceneOperation] Pushing scene \(scene)")
			push(newViewController, from: visibleViewController?.navigationController, animated: scene.isAnimated, completion: recursiveCall)

		case .modalNavigation:
			logTrace("[AddSceneOperation] Presenting inside navigation scene \(scene)")
			let navigationController = scene.sceneHandler.navigation(with: newViewController)
			present(navigationController, from: visibleViewController, animated: scene.isAnimated, completion: recursiveCall)

		case .modal:
			logTrace("[AddSceneOperation] Presenting scene \(scene)")
			present(newViewController, from: visibleViewController, animated: scene.isAnimated, completion: recursiveCall)

		case .root:
			logTrace("[AddSceneOperation] Setting root scene \(scene)")
			root(scene: scene, completion: recursiveCall)

		case .none:
			logTrace("[AddSceneOperation] Doing nothing for scene \(scene)")
			let firstLevelNavigation = manager.firstLevelNavigationController(matching: scene)
			if let firstLevelNavigation = firstLevelNavigation {
				manager.select(viewController: firstLevelNavigation)
			}
			recursiveShow(scenes: scenes, visibleViewController: firstLevelNavigation?.viewControllers.first, completion: completion)
		}
	}

	func newViewController(for scene: Scene) -> UIViewController? {
		switch scene.type {
		case .modal,
			 .modalNavigation,
			 .root,
			 .push:
			return scene.view()
		case .none:
			return manager.firstLevelNavigationController(matching: scene)
		}
	}
}

// MARK: Private methods

private extension AddSceneOperation {
	func present(_ viewController: UIViewController, from: UIViewController?, animated: Bool, completion: @escaping CompletionBlock) {
		guard let from = from else {
			completion()
			return
		}

		from.present(viewController, animated: animated, completion: completion)
	}

	func push(_ viewController: UIViewController, from: UINavigationController?, animated: Bool, completion: @escaping CompletionBlock) {
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
		manager.root(scene: scene).execute(with: completion)
	}
}
