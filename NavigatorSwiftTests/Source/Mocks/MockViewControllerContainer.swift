//
//  MockViewControllerContainer.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit
import NavigatorSwift

class MockViewControllerContainer: MockViewController {
	var _rootViewController = UIViewController()
	var rootViewController: UIViewController {
		return _rootViewController
	}

	var _firstLevelNavigationControllers: [UINavigationController] = []
	var firstLevelNavigationControllers: [UINavigationController] {
		return _firstLevelNavigationControllers
	}

	var _visibleNavigationController = UINavigationController()
	var visibleNavigationController: UINavigationController {
		return _visibleNavigationController
	}

	var _selectedViewController = false
	func select(viewController selectedViewController: UIViewController) {
		self._selectedViewController = true
	}

	var _canBeReuse = true
	func canBeReuse(by container: ViewControllerContainer) -> Bool {
		return true
	}
}

extension MockViewControllerContainer: ViewControllerContainer {

}
