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

		switch scene.type {
		case .push:
			logTrace("[AddSceneOperation] Pushing scene \(scene)")
			push(scene, from: visibleViewController?.navigationController, scenes: scenes, completion: completion)

		case .modalNavigation:
			logTrace("[AddSceneOperation] Presenting inside navigation scene \(scene)")
			presentNavigation(scene, from: visibleViewController, scenes: scenes, completion: completion)

		case .modal:
			logTrace("[AddSceneOperation] Presenting scene \(scene)")
			present(scene, from: visibleViewController, scenes: scenes, completion: completion)

		case .root:
			logTrace("[AddSceneOperation] Setting root scene \(scene)")
			root(scene: scene, scenes: scenes, completion: completion)

		case .select:
			logTrace("[AddSceneOperation] Doing nothing for scene \(scene)")
			select(scene, scenes: scenes, completion: completion)
		}
	}
}

// MARK: Private methods

private extension AddSceneOperation {
	func present(_ scene: Scene, from: UIViewController?, scenes: [Scene], completion: CompletionBlock?) {
		guard let from = from else {
			logTrace("[AddSceneOperation] Could not present \(scene). No fromViewController.")
			completion?()
			return
		}

		let viewController = scene.view()

		let recursiveCompletion: CompletionBlock = {
			self.recursiveShow(scenes: scenes, visibleViewController: viewController, completion: completion)
		}

		from.present(viewController, animated: scene.isAnimated, completion: recursiveCompletion)
	}

	func presentNavigation(_ scene: Scene, from: UIViewController?, scenes: [Scene], completion: CompletionBlock?) {
		guard let from = from else {
			logTrace("[AddSceneOperation] Could not present \(scene). No fromViewController.")
			completion?()
			return
		}

		let viewController = scene.sceneHandler.navigation(with: scene.view())

		let recursiveCompletion: CompletionBlock = {
			self.recursiveShow(scenes: scenes, visibleViewController: viewController.viewControllers.first, completion: completion)
		}

		from.present(viewController, animated: scene.isAnimated, completion: recursiveCompletion)
	}

	func push(_ scene: Scene, from: UINavigationController?, scenes: [Scene], completion: CompletionBlock?) {
		guard let from = from else {
			logTrace("[AddSceneOperation] Could not push \(scene). No navigation controller.")
			completion?()
			return
		}

		let viewController = scene.view()

		let recursiveCompletion: CompletionBlock = {
			self.recursiveShow(scenes: scenes, visibleViewController: viewController, completion: completion)
		}

		CATransaction.begin()
		from.pushViewController(viewController, animated: scene.isAnimated)
		CATransaction.setCompletionBlock(recursiveCompletion)
		CATransaction.commit()
	}

	func root(scene: Scene, scenes: [Scene], completion: CompletionBlock?) {
		let recursiveCompletion: CompletionBlock = {
			self.recursiveShow(scenes: scenes, visibleViewController: self.manager.rootViewController, completion: completion)
		}

		manager.root(scene: scene).execute(with: recursiveCompletion)
	}

	func select(_ scene: Scene, scenes: [Scene], completion: CompletionBlock?) {
		guard let firstLevelNavigation = manager.firstLevelNavigationController(matching: scene) else {
			logTrace("[AddSceneOperation] Could not select \(scene). No first level navigation controller.")
			completion?()
			return
		}

		manager.select(viewController: firstLevelNavigation)
		
		recursiveShow(scenes: scenes, visibleViewController: firstLevelNavigation.viewControllers.first, completion: completion)
	}
}
