//
//  NavigationBarContainer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

open class NavigationBarContainer: UINavigationController {

}

// MARK: ViewControllerContainer

extension NavigationBarContainer: ViewControllerContainer {
	public var rootViewController: UIViewController {
		return self
	}

	public var firstLevelNavigationControllers: [UINavigationController] {
		return [self]
	}

	public var visibleNavigationController: UINavigationController {
		return self
	}

	public func select(viewController: UIViewController) {
		popToRootViewController(animated: true)
	}
}
