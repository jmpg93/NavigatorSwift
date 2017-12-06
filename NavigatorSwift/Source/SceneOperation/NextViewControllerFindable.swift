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

public extension NextViewControllerFindable {
	func next(before viewController: UIViewController) -> UIViewController? {
		if let next = next(before: viewController, using: viewController.navigationController) {
			return next
		}

		if let next = next(before: viewController, using: viewController.presentedViewController) {
			return next
		}

		return nil
	}
}

private extension NextViewControllerFindable {
	func next(before viewController: UIViewController, using navigationController: UINavigationController?) -> UIViewController? {
		guard let navigationController = navigationController else { return nil }

		if let next = navigationController.viewControllers.after(item: viewController) {
			return next
		}

		if let presentedViewController = navigationController.presentedViewController {
			return contentViewController(with: presentedViewController)
		}

		return nil
	}

	func next(before viewController: UIViewController, using presentedViewController: UIViewController?) -> UIViewController? {
		guard let presentedViewController = presentedViewController else { return nil }

		if let navigationController = presentedViewController.navigationController {
			return navigationController.viewControllers.after(item: presentedViewController)
		}

		if let presentedViewController = presentedViewController.presentedViewController {
			return contentViewController(with: presentedViewController)
		}

		return nil
	}

	func contentViewController(with presentedViewController: UIViewController) -> UIViewController {
		guard let navigationController = presentedViewController as? UINavigationController else {
			 return presentedViewController
		}

		return navigationController.viewControllers.first ?? presentedViewController
	}
}

extension Array where Element: Hashable {
	func after(item: Element) -> Element? {
		if let index = self.index(of: item), index + 1 < self.count {
			return self[index + 1]
		}
		return nil
	}
}


