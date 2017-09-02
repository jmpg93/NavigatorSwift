//
//  ViewControllerContainer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerContainer: class {

	/// The root ViewController that will set as root of UIWindow.
	var rootViewController: UIViewController? { get }

	/// Returns the UINavigationController of each navigation stack managed. This is usfel for example by a UITabBarController.
	var firstLevelNavigationControllers: [UINavigationController] { get }

	///  Returns the visible navigationController.
	var visibleNavigationController: UINavigationController { get }

	/// Make the selectedViewController as visible.
	///
	/// This method is useful for TMViewControllerContainer that manage a various stacks of navigations, for example
	///  for a UITabBarController.
	func setSelectedViewController(_ selectedViewController: UIViewController)
}
