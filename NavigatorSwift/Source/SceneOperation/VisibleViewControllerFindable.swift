//
//  VisibleViewControllerFinder.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

protocol VisibleViewControllerFindable {
	func visibleViewController(from fromViewController: UIViewController) -> UIViewController
}

extension VisibleViewControllerFindable {
	func visibleViewController(from fromViewController: UIViewController) -> UIViewController {
		if let visibleViewController = (fromViewController as? UINavigationController)?.visibleViewController {
			return self.visibleViewController(from: visibleViewController)
		} else if let selectedViewController = (fromViewController as? UITabBarController)?.selectedViewController {
			return visibleViewController(from: selectedViewController)
		} else if let visibleViewController = (fromViewController as? ViewControllerContainer)?.visibleNavigationController.visibleViewController {
			return self.visibleViewController(from: visibleViewController)
		} else if let presentedViewController = fromViewController.presentedViewController {
			return visibleViewController(from: presentedViewController)
		} else {
			return fromViewController
		}
	}
}
