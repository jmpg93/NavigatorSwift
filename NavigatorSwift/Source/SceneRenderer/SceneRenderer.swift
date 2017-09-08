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

public extension SceneRenderer {

	/// Changes the current navigation stack to conform an array of Scenes, in the process of build the new navigation stack
	/// SceneRenderer will try to recycle the view controllers that are currently in the stack.
	///
	/// - parameter:  scenes An array of Scenes that represents how should be the new navigation stack.
	/// - parameter:  completion The block to execute after the last scene is presented.
	func set(scenes: [Scene], completion: CompletionBlock? = nil) {
		ChangeScenesOperation(scenes: scenes, sceneRendeded: self).execute(with: completion)
	}

	/// Adds an array of Scenes on to the current navigation stack.
	///
	/// - parameter: scenes An array of Scenes to add on to the navigation stack.
	/// - parameter: completion The block to execute after the last scene is presented.
	func add(scenes: [Scene], completion: CompletionBlock? = nil) {
		AddScenesOperation(scenes: scenes, rootViewController: rootViewController).execute(with: completion)
	}

	/// Pops the visible scene if he has a navigation controller.
	///
	/// - parameter: animated Pass YES to animate the transition.
	/// - parameter: completion The block to execute after the relevant scene is dismissed.
	func pop(animated: Bool, completion: CompletionBlock? = nil) -> UIViewController? {
		return PopSceneOperation(toRoot: false, rootViewController: rootViewController, animated: animated).execute(with: completion)?.first
	}


	///Pops to root view controller the visible scene if he has a navigation controller.
	///
	/// - parameter:  animated Pass YES to animate the transition.
	/// - parameter:  completion The block to execute after all scenes are dismissed.
	func popToRoot(animated: Bool, completion: CompletionBlock? = nil) -> [UIViewController]? {
		return PopSceneOperation(toRoot: true, rootViewController: rootViewController, animated: animated).execute(with: completion)
	}

	///Dismisses the visible scene if he was presented modally.
	///
	///- parameter:  animated Pass YES to animate the transition.
	///- parameter:  completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(animated: Bool, completion: CompletionBlock? = nil) {
		DismissFirstSceneOperation(visibleNavigationController: visibleNavigationController, animated: animated).execute(with: completion)
	}

	///Dismisses the visible scene if he matches the scene passed as parameter and also is presented modally.
	///
	/// - parameter: scene The Scene to dismiss.
	/// - parameter: animated Pass YES to animate the transition.
	/// - parameter: completion The block to execute after the scene is dismissed, if the scene has not been dismissed the completion block is not called.
	func dismiss(scene: Scene, animated: Bool, completion: CompletionBlock? = nil) {
		DismissSceneOperation(scene: scene, visibleNavigationController: visibleNavigationController, animated: animated).execute(with: completion)
	}
}

