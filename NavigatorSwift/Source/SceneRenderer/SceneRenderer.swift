//
//  SceneRenderer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public typealias CompletionBlock = () -> Void

public class SceneRenderer {
	// dependencies
	let window: UIWindow
	var viewControllerContainer: ViewControllerContainer?

	public init(window: UIWindow) {
		self.window = window
	}
}

// MARK: Private methods

public extension SceneRenderer {

	/// Changes the current navigation stack to conform an array of Scenes, in the process of build the new navigation stack
	/// SceneRenderer will try to recycle the view controllers that are currently in the stack.
	///
	/// - parameter:  scenes An array of Scenes that represents how should be the new navigation stack.
	/// - parameter:  completion The block to execute after the last scene is presented.
	func changeStack(toScenes scenes: [Scene], completion: CompletionBlock? = nil) {
		dismissAllViewControllers()

		guard let firstScene = scenes.first else { return }

		if isRootViewController(matching: firstScene) {
			recycleNavigationStack(with: scenes, completion: completion)
		} else {
			installScene(asRootViewController: firstScene)
			let scenesNotInStackYet = scenes.dropFirst()
			recycleNavigationStack(with: scenesNotInStackYet, completion: completion)
		}
	}

	/// Adds an array of Scenes on to the current navigation stack.
	///
	/// - parameter: scenes An array of Scenes to add on to the navigation stack.
	/// - parameter: completion The block to execute after the last scene is presented.
	func addScenesOntoStack(_ scenes: [Scene], completion: CompletionBlock? = nil) {
		guard !scenes.isEmpty else { return }

		if viewControllerContainer == nil {
			installScene(asRootViewController: scenes.first!)
		}

		guard let rootViewController = viewControllerContainer?.rootViewController else {
			return
		}

		let visibleViewController = self.visibleViewController(from: rootViewController)
		renderScenes(scenes, fromVisibleViewController: visibleViewController, completion: completion)
	}


	/// Pops the visible scene if he has a navigation controller.
	///
	/// - parameter: animated Pass YES to animate the transition.
	/// - parameter: completion The block to execute after the relevant scene is dismissed.

	func popScene(animated: Bool, completion: CompletionBlock? = nil) -> UIViewController? {
		return popScenes(toRoot: false, animated: animated, completion: completion)?.first
	}


	///Pops to root view controller the visible scene if he has a navigation controller.
	///
	/// - parameter:  animated Pass YES to animate the transition.
	/// - parameter:  completion The block to execute after all scenes are dismissed.
	func popToRootScene(animated: Bool, completion: CompletionBlock? = nil) -> [UIViewController]? {
		return popScenes(toRoot: true, animated: animated, completion: completion)
	}

	///Dismisses the visible scene if he was presented modally.
	///
	///- parameter:  animated Pass YES to animate the transition.
	///- parameter:  completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismissScene(animated: Bool, completion: CompletionBlock? = nil) {
		guard let viewControllerContainer = viewControllerContainer else { return }

		let visibleViewController = self.visibleViewController(from: viewControllerContainer.visibleNavigationController)

		if visibleViewController.isBeingDisplayedModally {
			visibleViewController.dismiss(animated: animated, completion: completion)
		}
	}

	///Dismisses the visible scene if he matches the scene passed as parameter and also is presented modally.
	///
	/// - parameter: scene The Scene to dismiss.
	/// - parameter: animated Pass YES to animate the transition.
	/// - parameter: completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(_ scene: Scene, animated: Bool, completion: CompletionBlock? = nil) {
		guard let rootViewController = viewControllerContainer?.rootViewController else { return }

		let visibleViewController = self.visibleViewController(from: rootViewController)

		if visibleViewController.isBeingDisplayedModally && scene.sceneHandler.name.value == visibleViewController.sceneName {
			visibleViewController.dismiss(animated: animated, completion: completion)
		}
	}
}

// MARK: Private methods

extension SceneRenderer {
	func recycleNavigationStack(with scenes: [Scene], completion: CompletionBlock? = nil) {
		guard let viewControllerContainer = viewControllerContainer else { return }
		guard !scenes.isEmpty else { return }

		var scenesNotInStackYet = scenes
		var optionalNavigationControllerToRecycle: UINavigationController? = nil

		// If the root view controller is not a UINavigationController we must recycle it.
		if let rootViewController = viewControllerContainer.rootViewController, !(rootViewController is UINavigationController) {
			recycleRootViewController(with: scenesNotInStackYet.removeFirst())
		}

		guard let firstSceneNotInStack = scenesNotInStackYet.first else { return }
		guard let navigationControllerToRecycle = viewControllerContainer.firstLevelNavigationController(matching: firstSceneNotInStack) else { return }

		viewControllerContainer.setSelectedViewController(navigationControllerToRecycle)

		var finalViewControllers: [UIViewController] = []
		for (index, viewControllerToRecycle) in navigationControllerToRecycle.viewControllers.enumerated() {
			let searchingScene = scenesNotInStackYet.first!

			if isViewController(viewControllerToRecycle, recyclableBy: viewControllerToRecycle) {
				finalViewControllers.append(viewControllerToRecycle)
				searchingScene.sceneHandler.reload(viewControllerToRecycle, parameters: searchingScene.parameters)
				scenesNotInStackYet.remove(at: 0)
			} else {

			}
		}

		// Finaly add scenes not in stack yet.
		if let visibleViewController = navigationControllerToRecycle.visibleViewController {
			renderScenes(scenesNotInStackYet, fromVisibleViewController: visibleViewController, completion: completion)
		}
	}

	func popScenes(toRoot popToRoot: Bool, animated: Bool, completion: CompletionBlock? = nil) -> [UIViewController]? {
		var poppedViewControllers: [UIViewController]? = nil

		guard let rootViewController = viewControllerContainer?.rootViewController else {
			return nil
		}

		let visibleViewController = self.visibleViewController(from: rootViewController)

		guard let navigationController = visibleViewController.navigationController else {
			return nil
		}

		if popToRoot {
			poppedViewControllers = navigationController.popToRootViewController(animated: animated)
		} else if let poppedViewController = navigationController.popViewController(animated: animated) {
			poppedViewControllers = [poppedViewController]
		}

		let animationTime: TimeInterval = animated
			? UIView.defaultAnimationDuration / TimeInterval(window.layer.speed)
			: 0.0

		DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
			completion?()
		}

		return poppedViewControllers
	}

	func installScene(asRootViewController scene: Scene) {

		let rootViewController = scene.sceneHandler._buildViewController(with: scene.parameters)

		if let rootViewController = rootViewController as? ViewControllerContainer {
			self.viewControllerContainer = rootViewController
		} else {
			self.viewControllerContainer = NavigationBarContainer()
			let navigationController = viewControllerContainer!.visibleNavigationController
			navigationController.pushViewController(rootViewController, animated: false)
		}

		window.rootViewController = viewControllerContainer!.rootViewController
		window.makeKeyAndVisible()
	}

	func recycleRootViewController(with scene: Scene) {
		guard let rootViewController = viewControllerContainer?.rootViewController else { return }

		//TODO: Check if scene correspond to rootViewController
		scene.sceneHandler.reload(rootViewController, parameters: scene.parameters)
	}

	func dismissAllViewControllers() {
		viewControllerContainer?.rootViewController?.dismiss(animated: true, completion: nil)
	}

	///Returns Yes if the viewController is handled by the scene and also is presented as require the scene, NO otherwise.
	func isViewController(_ viewController: UIViewController,
	                      recyclableBy scene: Scene) -> Bool {
		let isManagedByScene = scene.sceneHandler.name.value == viewController.sceneName
		let isPresentedAsRequireScene = isViewController(viewController, presentedAsRequire: scene)
		let isViewControllerRecyclable = scene.sceneHandler.isViewControllerRecyclable

		return isManagedByScene && isPresentedAsRequireScene && isViewControllerRecyclable
	}

	/// Returns true if the rootViewController in Window is handled by the scene
	func isRootViewController(matching scene: Scene) -> Bool {
		guard let viewControllerContainer = viewControllerContainer else { return false }

		var isEqual: Bool = false

		if let rootViewController = viewControllerContainer.rootViewController as? UINavigationController {
			isEqual = rootViewController.viewControllers.first?.sceneName == scene.sceneHandler.name.value
		}

		return isEqual
	}

	func renderScenes(_ scenes: [Scene],
	                  fromVisibleViewController visibleViewController: UIViewController,
	                  completion: (CompletionBlock)? = nil) {

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
			let wrapperCompletion: (CompletionBlock)? = completion //scene == scenes ? completion : nil

			switch scene.type {
			case .push:
				navigationController?.pushViewController(newViewController, animated: animated)

			case .modalInsideNavigationBar:
				let navigationController = UINavigationController(rootViewController: newViewController)
				navigationController.modalPresentationStyle = newViewController.modalPresentationStyle
				navigationController.transitioningDelegate = newViewController.transitioningDelegate
				newViewController.transitioningDelegate = nil
				visibleViewController.present(navigationController, animated: animated, completion: wrapperCompletion)

			case .modal:
				visibleViewController.present(newViewController, animated: animated, completion: wrapperCompletion)
			}

			currentVisibleViewController = newViewController
			navigationController = currentVisibleViewController?.navigationController
		}
	}

	func isViewController(_ viewController: UIViewController,
	                      presentedAsRequire scene: Scene) -> Bool {

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

	func visibleViewController(from fromViewController: UIViewController) -> UIViewController {
		if let visibleViewController = (fromViewController as? UINavigationController)?.visibleViewController {
			return self.visibleViewController(from: visibleViewController)
		} else if let selectedViewController = (fromViewController as? UITabBarController)?.selectedViewController {
			return visibleViewController(from: selectedViewController)
		} else if let visibleViewController = (fromViewController as? ViewControllerContainer)?.visibleNavigationController.visibleViewController {
			return self.visibleViewController(from: visibleViewController)
		} else if let presentedViewController = fromViewController.presentedViewController {
			return visibleViewController(from: presentedViewController)
		} else {
			return fromViewController
		}
	}
}
