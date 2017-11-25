//
//  MockViewController.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class MockViewController: UIViewController {
	var dismissed = false
	var _isBeingDisplayedModally = false
	var _navigationController: UINavigationController? = nil
	var _presentingViewController: UIViewController? = nil

	var didPresentViewController = false

	var overrideNavigationController = false
	override var navigationController: UINavigationController? {
		return overrideNavigationController ? _navigationController : super.navigationController
	}

	var overridePresentingViewController = false
	override var presentingViewController: UIViewController? {
		return overridePresentingViewController ? _presentingViewController : super.presentingViewController
	}

	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		dismissed = true
	}

	var isBeingDisplayedModally: Bool {
		return _isBeingDisplayedModally
	}

	override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
		didPresentViewController = true
	}
}
