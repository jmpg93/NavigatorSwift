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

class MockViewControllerContainer: ViewControllerContainer {
	var _rootViewController = UIViewController()
	var _firstLevelNavigationControllers: [UINavigationController] = []
	var _visibleNavigationController = UINavigationController()
	var _selectedViewController = false

	var rootViewController: UIViewController {
		return _rootViewController
	}

	var firstLevelNavigationControllers: [UINavigationController] {
		return _firstLevelNavigationControllers
	}

	var visibleNavigationController: UINavigationController {
		return _visibleNavigationController
	}

	func setSelectedViewController(_ selectedViewController: UIViewController) {
		self._selectedViewController = true
	}
}
