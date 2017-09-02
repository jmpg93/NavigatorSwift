//
//  NavigationBarContainer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class NavigationBarContainer {
	let navigationController = UINavigationController()
}

extension NavigationBarContainer: ViewControllerContainer {
	var rootViewController: UIViewController? {
		return navigationController
	}
	
	var firstLevelNavigationControllers: [UINavigationController] {
		return [navigationController]
	}

	var visibleNavigationController: UINavigationController {
		return navigationController
	}

	func setSelectedViewController(_ rootViewController: UIViewController) {
		navigationController.popToRootViewController(animated: true)
	}
}
