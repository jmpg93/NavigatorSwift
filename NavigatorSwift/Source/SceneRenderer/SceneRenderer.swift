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

public class SceneRenderer: VisibleViewControllerFindable {
	let window: UIWindow
	var viewControllerContainer: ViewControllerContainer

	public init(window: UIWindow, viewControllerContainer: ViewControllerContainer) {
		self.window = window
		self.viewControllerContainer = viewControllerContainer

		window.rootViewController = viewControllerContainer.rootViewController
	}

	var rootViewController: UIViewController {
		return viewControllerContainer.rootViewController
	}

	var visibleNavigationController: UINavigationController {
		return viewControllerContainer.visibleNavigationController
	}

	func setSelectedViewController(_ selectedViewController: UIViewController) {
		viewControllerContainer.setSelectedViewController(selectedViewController)
	}

	func install(scene: Scene) -> SceneOperation {
		return InstallSceneOperation(scene: scene,
		                             renderer: self)
	}

	func add(scenes: [Scene]) -> SceneOperation {
		return AddSceneOperation(scenes: scenes,
		                         renderer: self)
	}

	func set(scenes: [Scene]) -> SceneOperation {
		return SetScenesOperation(scenes: scenes,
		                          renderer: self)
	}

	func dismiss(scene: Scene, animated: Bool) -> SceneOperation {
		return DismissSceneOperation(scene: scene,
		                             animated: animated,
		                             renderer: self)
	}

	func dismissFirst(animated: Bool) -> SceneOperation {
		return DismissFirstSceneOperation(animated: animated,
		                                  renderer: self)
	}

	func dismissAll(animated: Bool) -> SceneOperation {
		return DismisAllViewControllerOperation(animated: animated,
		                                        renderer: self)
	}

	func popToRoot(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: true,
		                         animated: animated,
		                         renderer: self)
	}

	func pop(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: false,
		                         animated: animated,
		                         renderer: self)
	}

	func recycle(scenes: [Scene]) -> SceneOperation {
		return RecycleSceneOperation(scenes: scenes,
		                             renderer: self)
	}

	func transition(delegate: UIViewControllerTransitioningDelegate, toViewController: UIViewController) -> SceneOperation {
		return ApplyTransitionSceneOperation(delegate: delegate,
		                                     toViewController: toViewController,
		                                     renderer: self)
	}
}

// MARK: Private methods

public extension SceneRenderer {
	/// Changes the current navigation stack to conform an array of Scenes, in the process of build the new navigation stack
	/// SceneRenderer will try to recycle the view controllers that are currently in the stack.
	///
	/// - parameter:  scenes An array of Scenes that represents how should be the new navigation stack.
	/// - parameter:  completion The block to execute after the last scene is presented.
	func set(scenes: [Scene], completion: CompletionBlock? = nil) {
		set(scenes: scenes).execute(with: completion)
	}

	/// Adds an array of Scenes on to the current navigation stack.
	///
	/// - parameter: scenes An array of Scenes to add on to the navigation stack.
	/// - parameter: completion The block to execute after the last scene is presented.
	func add(scenes: [Scene], completion: CompletionBlock? = nil) {
		add(scenes: scenes).execute(with: completion)
	}

	/// Pops the visible scene if he has a navigation controller.
	///
	/// - parameter: animated Pass YES to animate the transition.
	/// - parameter: completion The block to execute after the relevant scene is dismissed.
	func pop(animated: Bool, completion: CompletionBlock? = nil) {
		pop(animated: animated).execute(with: completion)
	}


	///Pops to root view controller the visible scene if he has a navigation controller.
	///
	/// - parameter:  animated Pass YES to animate the transition.
	/// - parameter:  completion The block to execute after all scenes are dismissed.
	func popToRoot(animated: Bool, completion: CompletionBlock? = nil) {
		popToRoot(animated: animated).execute(with: completion)
	}

	///Dismisses the visible scene if he was presented modally.
	///
	///- parameter:  animated Pass YES to animate the transition.
	///- parameter:  completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(animated: Bool, completion: CompletionBlock? = nil) {
		dismissFirst(animated: animated).execute(with: completion)
	}

	///Dismisses the visible scene if he matches the scene passed as parameter and also is presented modally.
	///
	/// - parameter: scene The Scene to dismiss.
	/// - parameter: animated Pass YES to animate the transition.
	/// - parameter: completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(scene: Scene, animated: Bool, completion: CompletionBlock? = nil) {
		dismiss(scene: scene, animated: animated).execute(with: completion)
	}
}
