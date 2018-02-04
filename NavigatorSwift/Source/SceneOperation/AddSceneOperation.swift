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
	private let scenes: [Scene]
	private let manager: SceneOperationManager

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

		guard let rootViewController = manager.rootViewController else {
			logTrace("[AddSceneOperation] No root view controller found")
			completion?()
			return
		}

		let visibleViewController = manager.visible(from: rootViewController)

		recursiveShow(scenes: scenes, visibleViewController: visibleViewController, completion: completion)
	}

	func context() -> InterceptorContext {
		let from = manager.state(from: manager.rootViewController)
		let to = scenes.map(ScenePresentationState.init)

		return InterceptorContext(from: from, to: to)
	}
}

// MARK: Private method

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
			logTrace("[AddSceneOperation] Pushing scene \(scene)")
			self.push(from: visibleViewController?.navigationController, newViewController, animated: animated, completion: recursiveCall)

		case .modalNavigation:
			logTrace("[AddSceneOperation] Presenting inside navigation scene \(scene)")
			let navigationController = scene.sceneHandler.navigation(with: newViewController)
			self.present(from: visibleViewController, navigationController, animated: animated, completion: recursiveCall)

		case .modal:
			logTrace("[AddSceneOperation] Presenting scene \(scene)")
			self.present(from: visibleViewController, newViewController, animated: animated, completion: recursiveCall)

		case .root:
			logTrace("[AddSceneOperation] Setting root scene \(scene)")
			self.root(scene: scene, completion: recursiveCall)

		case .none:
			logTrace("[AddSceneOperation] Doing nothing for scene \(scene)")
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
