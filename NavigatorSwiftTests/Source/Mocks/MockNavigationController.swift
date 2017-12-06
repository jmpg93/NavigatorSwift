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

	var _isBeingDisplayedModally = false
	var isBeingDisplayedModally: Bool {
		return _isBeingDisplayedModally
	}

	var overridePresentingViewController = false
	var _presentingViewController: UIViewController? = nil
	override var presentingViewController: UIViewController? {
		return overridePresentingViewController ? _presentingViewController : super.presentingViewController
	}

	var dismissed = false
	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		dismissed = true
	}

	var popped = false
	override func popViewController(animated: Bool) -> UIViewController? {
		popped = true
		return nil
	}

	var poppedToRoot = false
	override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		poppedToRoot = true
		return nil
	}

	var pushed = false
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		pushed = true
	}
}
