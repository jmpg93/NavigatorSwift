//
//  MockViewControllerContainer.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit
@testable import NavigatorSwift

class MockViewControllerContainer: MockViewController, ViewControllerContainer {
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
	func select(viewController_ selectedViewController: UIViewController) {
		self._selectedViewController = true
	}
}
