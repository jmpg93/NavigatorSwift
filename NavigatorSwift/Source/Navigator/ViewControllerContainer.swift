//
//  ViewControllerContainer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerContainer: class {

	/// The root ViewController that will set as root of UIWindow.
	var rootViewController: UIViewController { get }

	/// Returns the UINavigationController of each navigation stack managed. This is usfel for example by a UITabBarController.
	var firstLevelNavigationControllers: [UINavigationController] { get }

	/// Returns the visible navigationController.
	var visibleNavigationController: UINavigationController { get }

	/// Make the selectedViewController as visible.
	///
	/// This method is useful for ViewControllerContainer that manage a various stacks of navigations, for example
	/// for a UITabBarController.
	func select(viewController: UIViewController)
}

extension ViewControllerContainer {
	func firstLevelNavigationController(matching scene: Scene) -> UINavigationController? {
		return firstLevelNavigationControllers
			.lazy
			.flatMap { $0.viewControllers.first }
			.filter { scene.sceneHandler.name.value == $0.sceneName }
			.flatMap { $0.navigationController }
			.first
	}

	public func canBeReused(by container: ViewControllerContainer) -> Bool {
		guard let sceneName = container.rootViewController.sceneName else { return false }
		return sceneName == rootViewController.sceneName
	}
}
