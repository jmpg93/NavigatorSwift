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

	func installOperation(scene: Scene) -> SceneOperation {
		return InstallSceneOperation(scene: scene,
		                             renderer: self)
	}

	func addOperation(scenes: [Scene]) -> SceneOperation {
		return AddSceneOperation(scenes: scenes,
		                         renderer: self)
	}

	func setOperation(scenes: [Scene]) -> SceneOperation {
		return SetScenesOperation(scenes: scenes,
		                          renderer: self)
	}

	func dismissOperation(scene: Scene, animated: Bool) -> SceneOperation {
		return DismissSceneOperation(scene: scene,
		                             animated: animated,
		                             renderer: self)
	}

	func dismissFirstOperation(animated: Bool) -> SceneOperation {
		return DismissFirstSceneOperation(animated: animated,
		                                  renderer: self)
	}

	func dismissAllOperation(animated: Bool) -> SceneOperation {
		return DismisAllViewControllerOperation(animated: animated,
		                                        renderer: self)
	}

	func popToRootOperation(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: true,
		                         animated: animated,
		                         renderer: self)
	}

	func popOperation(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: false,
		                         animated: animated,
		                         renderer: self)
	}

	func recycleOperation(scenes: [Scene]) -> SceneOperation {
		return RecycleSceneOperation(scenes: scenes,
		                             renderer: self)
	}

	func transitionOperation(delegate: UIViewControllerTransitioningDelegate, toViewController: UIViewController) -> SceneOperation {
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
		setOperation(scenes: scenes).execute(with: completion)
	}

	/// Adds an array of Scenes on to the current navigation stack.
	///
	/// - parameter: scenes An array of Scenes to add on to the navigation stack.
	/// - parameter: completion The block to execute after the last scene is presented.
	func add(scenes: [Scene], completion: CompletionBlock? = nil) {
		addOperation(scenes: scenes).execute(with: completion)
	}

	/// Pops the visible scene if he has a navigation controller.
	///
	/// - parameter: animated Pass true to animate the transition.
	/// - parameter: completion The block to execute after the relevant scene is dismissed.
	func pop(animated: Bool, completion: CompletionBlock? = nil) {
		popOperation(animated: animated).execute(with: completion)
	}


	///Pops to root view controller the visible scene if he has a navigation controller.
	///
	/// - parameter:  animated Pass true to animate the transition.
	/// - parameter:  completion The block to execute after all scenes are dismissed.
	func popToRoot(animated: Bool, completion: CompletionBlock? = nil) {
		popToRootOperation(animated: animated).execute(with: completion)
	}

	///Dismisses the visible scene if he was presented modally.
	///
	///- parameter:  animated Pass true to animate the transition.
	///- parameter:  completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(animated: Bool, completion: CompletionBlock? = nil) {
		dismissFirstOperation(animated: animated).execute(with: completion)
	}

	///Dismisses the visible scene if he matches the scene passed as parameter and also is presented modally.
	///
	/// - parameter: scene The Scene to dismiss.
	/// - parameter: animated Pass true to animate the transition.
	/// - parameter: completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(scene: Scene, animated: Bool, completion: CompletionBlock? = nil) {
		dismissOperation(scene: scene, animated: animated).execute(with: completion)
	}
}
