//
//  SceneOperationManager.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public typealias CompletionBlock = () -> Void

public class SceneOperationManager: HierarchyStateSearchable {
	let window: UIWindow
	private var viewControllerContainer: ViewControllerContainer?

	public init(window: UIWindow) {
		self.window = window
	}

	public var rootViewController: UIViewController? {
		return viewControllerContainer?.rootViewController
	}

	public var visibleNavigationController: UINavigationController? {
		return viewControllerContainer?.visibleNavigationController
	}

	func set(container: ViewControllerContainer) {
		viewControllerContainer = container
		window.rootViewController = container.rootViewController
		window.makeKeyAndVisible()
	}

	func select(viewController: UIViewController) {
		viewControllerContainer?.select(viewController: viewController)
	}

	func canReused(container: ViewControllerContainer) -> Bool {
		return viewControllerContainer?.canBeReused(by: container) ?? false
	}

	func firstLevelNavigationController(matching scene: Scene) -> UINavigationController? {
		return viewControllerContainer?.firstLevelNavigationController(matching: scene)
	}

	/// Changes the current navigation stack to conform an array of Scenes, in the process of build the new navigation stack
	/// SceneOperationManager will try to recycle the view controllers that are currently in the stack.
	///
	/// - parameter scenes: An array of Scenes that represents how should be the new navigation stack.
	func set(scenes: [Scene]) -> SceneOperation {
		return SetScenesOperation(scenes: scenes, manager: self)
	}

	/// Adds an array of Scenes on to the current navigation stack.
	///
	/// - parameter scenes: An array of Scenes to add on to the navigation stack.
	func add(scenes: [Scene]) -> SceneOperation {
		return AddSceneOperation(scenes: scenes, manager: self)
	}

	/// Pops the visible scene if he has a navigation controller.
	///
	/// - parameter animated: Pass true to animate the transition.
	func pop(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: false, animated: animated, manager: self)
	}
	
	/// Pops to root view controller the visible scene if he has a navigation controller.
	///
	/// - parameter animated: Pass true to animate the transition.
	func popToRoot(animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: true, animated: animated, manager: self)
	}

	/// Dismisses the visible scene if he was presented modally.
	///
	/// - parameter animated: Pass true to animate the transition.
	func dismiss(animated: Bool) -> SceneOperation {
		return DismissFirstSceneOperation(animated: animated, manager: self)
	}

	/// Dismisses the visible scene if he matches the scene passed as parameter and also is presented modally.
	///
	/// - parameter sceneName: The SceneName to dismiss.
	/// - parameter animated: Pass true to animate the transition.
	func dismiss(sceneName: SceneName, animated: Bool) -> SceneOperation {
		return DismissSceneOperation(sceneName: sceneName, animated: animated, manager: self)
	}

	/// Set the scene as root with a new viewControllerContainer.
	///
	/// - parameter scene: Scene to set as root.
	func root(scene: Scene) -> SceneOperation {
		return RootSceneOperation(scene: scene, manager: self)
	}

	/// Dismisses all scenes if any.
	///
	/// - parameter animated: Pass true to animate the transition.
	func dismissAll(animated: Bool) -> SceneOperation {
		return DismissAllOperation(animated: animated, manager: self)
	}

	/// Recycle the current stack, and install the scenes not in stack yet.
	///
	/// - parameter scenes: The scenes to be recycled.
	func recycle(scenes: [Scene]) -> SceneOperation {
		return RecycleSceneOperation(scenes: scenes, manager: self)
	}

	/// Reload the visible viewController if the scenes matches.
	///
	/// - parameter scene: The scene to be reloaded.
	func reload(scene: Scene) -> SceneOperation {
		return ReloadSceneOperation(scene: scene, manager: self)
	}

	/// Present the view controller using the transition passed as parameter.
	///
	/// - parameter transition: Transition to acomplish.
	/// - parameter scene: Target scene.
	func transition(_ transition: Transition, to scene: Scene) -> SceneOperation {
		return ApplyTransitionSceneOperation(transition: transition, to: scene, manager: self)
	}

	/// Present the view controller as a popover.
	///
	/// - parameter popover: Configuration object for the presentation.
	/// - parameter scene: Target scene.
	func popover(_ popover: Popover, to scene: Scene) -> SceneOperation {
		return PopoverSceneOperation(popover: popover, to: scene, manager: self)
	}

	/// Pop and dismiss every view controller above the given view controller.
	///
	/// - parameter viewController: The view controller to set as visible.
	func setVisible(viewController: UIViewController) -> SceneOperation {
		return SetVisibleSceneOperation(viewController: viewController, manager: self)
	}

	/// Creates the current stack based on the hierarchy of the app.
	///
	/// - parameter block: The block to be execute with the current stack
	func traverse(block: @escaping TraverseBlock) -> SceneOperation {
		return TraverseSceneOperation(traverseBlock: block, manager: self)
	}
}

