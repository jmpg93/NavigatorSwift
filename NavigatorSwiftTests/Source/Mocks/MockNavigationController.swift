//
//  MockNavigationController.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class MockNavigationController: UINavigationController {
	var dismissed = false
	var popped = false
	var poppedToRoot = false
	var pushed = false
	var _isBeingDisplayedModally = false
	var _presentingViewController: UIViewController? = nil
	var _viewControllers: [UIViewController] = []

	convenience init() {
		self.init(viewControllers: [])
	}

	init(viewControllers: [UIViewController]) {
		super.init(nibName: nil, bundle: nil)
		setValue(viewControllers, forKey: "viewControllers")
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	var isBeingDisplayedModally: Bool {
		return _isBeingDisplayedModally
	}

	var overridePresentingViewController = false
	override var presentingViewController: UIViewController? {
		return overridePresentingViewController ? _presentingViewController : super.presentingViewController
	}

	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		dismissed = true
	}

	override func popViewController(animated: Bool) -> UIViewController? {
		popped = true
		return nil
	}

	override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		poppedToRoot = true
		return nil
	}

	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		pushed = true
	}
}
