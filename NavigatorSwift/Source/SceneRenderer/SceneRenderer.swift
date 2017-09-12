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
}

// MARK: Private methods

extension SceneRenderer {
	/// Changes the current navigation stack to conform an array of Scenes, in the process of build the new navigation stack
	/// SceneRenderer will try to recycle the view controllers that are currently in the stack.
	///
	/// - parameter:  scenes An array of Scenes that represents how should be the new navigation stack.
	func set(scenes: [Scene]) -> SceneOperation {
		return SetScenesOperation(scenes: scenes, renderer: self)
	}

	/// Adds an array of Scenes on to the current navigation stack.
	///
	/// - parameter: scenes An array of Scenes to add on to the navigation stack.
	func add(scenes: [Scene]) -> SceneOperation {
		return AddSceneOperation(scenes: scenes, renderer: self)
	}

	/// Pops the visible scene if he has a navigation controller.
	///
	/// - parameter: animated Pass true to animate the transition.
	func pop(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: false, animated: animated, renderer: self)
	}


	///Pops to root view controller the visible scene if he has a navigation controller.
	///
	/// - parameter:  animated Pass true to animate the transition.
	func popToRoot(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: true, animated: animated, renderer: self)
	}

	///Dismisses the visible scene if he was presented modally.
	///
	///- parameter:  animated Pass true to animate the transition.
	func dismiss(animated: Bool) -> SceneOperation {
		return DismissFirstSceneOperation(animated: animated, renderer: self)
	}

	///Dismisses the visible scene if he matches the scene passed as parameter and also is presented modally.
	///
	/// - parameter: scene The Scene to dismiss.
	/// - parameter: animated Pass true to animate the transition.
	func dismiss(scene: Scene, animated: Bool) -> SceneOperation {
		return  DismissSceneOperation(scene: scene, animated: animated, renderer: self)
	}

	func installOperation(scene: Scene) -> SceneOperation {
		return InstallSceneOperation(scene: scene, renderer: self)
	}
	
	func dismissAllOperation(animated: Bool) -> SceneOperation {
		return DismisAllViewControllerOperation(animated: animated, renderer: self)
	}

	func recycleOperation(scenes: [Scene]) -> SceneOperation {
		return RecycleSceneOperation(scenes: scenes, renderer: self)
	}

	func transitionOperation(delegate: UIViewControllerTransitioningDelegate, toViewController: UIViewController) -> SceneOperation {
		return ApplyTransitionSceneOperation(delegate: delegate, toViewController: toViewController, renderer: self)
	}
}
