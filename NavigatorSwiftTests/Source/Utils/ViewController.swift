//
//  ViewController.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

open class NavigationController: UINavigationController {
	open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		super.dismiss(animated: flag, completion: completion)
	}
}

open class ViewController: UIViewController {
	open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		super.dismiss(animated: flag, completion: completion)
	}

	var isBeingDisplayedModally: Bool {
		let presentedModally = presentingViewController?.presentedViewController == self
		let ancestorNavigationControllerPresentedModally = navigationController != nil && navigationController?.presentingViewController?.presentedViewController == navigationController
		let ancestorTabBarControllerPresentedModally = tabBarController?.presentingViewController is UITabBarController

		return presentedModally || ancestorNavigationControllerPresentedModally || ancestorTabBarControllerPresentedModally
	}
}

open class MockWindow: UIWindow {
	var madeKeyAndVisible = false

	override open func makeKeyAndVisible() {
		madeKeyAndVisible = true
	}
}
