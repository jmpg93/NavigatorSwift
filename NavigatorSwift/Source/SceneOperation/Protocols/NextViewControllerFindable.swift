//
//  NextViewControllerFinder.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 5/12/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol NextViewControllerFindable {
	func next(before viewController: UIViewController) -> UIViewController?
}

// MARK: Default implementation

public extension NextViewControllerFindable {
	func next(before viewController: UIViewController) -> UIViewController? {
		if let content = contentViewController(with: viewController) {
			return content
		}

		if let next = next(before: viewController, using: viewController.navigationController) {
			return next
		}

		if let next = next(before: viewController, using: viewController.presentedViewController) {
			return next
		}

		return nil
	}
}

// MARK: Private methods

private extension NextViewControllerFindable {
	func next(before viewController: UIViewController, using navigationController: UINavigationController?) -> UIViewController? {
		guard let navigationController = navigationController else { return nil }

		if let next = navigationController.viewControllers.after(item: viewController) {
			return next
		}

		if let presentedViewController = navigationController.presentedViewController {
			return contentViewController(with: presentedViewController) ?? presentedViewController
		}

		return nil
	}

	func next(before viewController: UIViewController, using presentedViewController: UIViewController?) -> UIViewController? {
		guard let presentedViewController = presentedViewController else { return nil }

		if let content = contentViewController(with: presentedViewController) {
			return content
		}

		if let presentedViewController = presentedViewController.presentedViewController {
			return contentViewController(with: presentedViewController) ?? presentedViewController
		}

		return presentedViewController
	}

	func contentViewController(with container: UIViewController) -> UIViewController? {
		if let navigation = container as? UINavigationController, let first = navigation.viewControllers.first {
			return contentViewController(with: first) ?? first
		}

		if let tabBar = container as? UITabBarController, let selected = tabBar.selectedViewController {
			return contentViewController(with: selected) ?? selected
		}

		if let viewControllerContainer = container as? ViewControllerContainer {
			let visible = viewControllerContainer.visibleNavigationController
			return contentViewController(with: visible) ?? visible
		}
		
		return nil
	}
}
