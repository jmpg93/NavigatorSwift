//
//  SceneHandler.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol SceneHandler: class {
	var name: SceneName { get }
	var isReloadable: Bool { get }

	func view(with parameters: Parameters) -> UIViewController
	func navigation(with viewController: UIViewController) -> UINavigationController
	func reload(_ viewController: UIViewController, parameters: Parameters)
}

public extension SceneHandler {
	var isReloadable: Bool {
		return true
	}

	func navigation(with viewController: UIViewController) -> UINavigationController {
		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.modalPresentationStyle = viewController.modalPresentationStyle
		navigationController.transitioningDelegate = viewController.transitioningDelegate
		viewController.transitioningDelegate = nil
		return navigationController
	}

	func reload(_ viewController: UIViewController, parameters: Parameters) {
		// Do nothing by default
	}
}
