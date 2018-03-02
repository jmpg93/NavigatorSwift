//
//  MockViewController.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit
import NavigatorSwift

class MockViewController: UIViewController {
	var overrideNavigationController = false
	var _navigationController: UINavigationController? = nil
	override var navigationController: UINavigationController? {
		return overrideNavigationController ? _navigationController : super.navigationController
	}

	var overridePresentingViewController = false
	var _presentingViewController: UIViewController? = nil
	override var presentingViewController: UIViewController? {
		return overridePresentingViewController ? _presentingViewController : super.presentingViewController
	}

	var overridePresentedViewController = false
	var _presentedViewController: UIViewController? = nil
	override var presentedViewController: UIViewController? {
		return _presentedViewController
	}

	var dismissed = false
	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		dismissed = true
	}

	var _isBeingDisplayedModally = false
	var isBeingDisplayedModally: Bool {
		return _isBeingDisplayedModally
	}
	
	var didPresentViewController = false
	override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
		didPresentViewController = true
	}
}
