//
//  TabBarContainer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class TabBarContainer {
	let tabBarController = UITabBarController()
}

extension TabBarContainer: ViewControllerContainer {
	var rootViewController: UIViewController {
		return tabBarController
	}

	var firstLevelNavigationControllers: [UINavigationController] {
		let viewControllers = tabBarController.viewControllers ?? []
		return viewControllers.flatMap { $0 as? UINavigationController }
	}

	var visibleNavigationController: UINavigationController {
		return tabBarController.selectedViewController as! UINavigationController
	}

	func setSelectedViewController(_ rootViewController: UIViewController) {
		tabBarController.selectedViewController = rootViewController
	}
	
}
