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
	var name: String { get }
	var isViewControllerRecyclable: Bool { get }

	func buildViewController(with parameters: Parameters) -> UIViewController
	func reload(_ viewController: UIViewController, parameters: Parameters)
}

public extension SceneHandler {
	var isViewControllerRecyclable: Bool {
		return false
	}

	func reload(_ viewController: UIViewController, parameters: Parameters) { }
}

extension SceneHandler {
	func _buildViewController(with parameters: Parameters) -> UIViewController {
		let viewController = buildViewController(with: parameters)
		viewController.sceneName = name
		return viewController
	}
}
