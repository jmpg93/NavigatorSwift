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
	func reload(_ viewController: UIViewController, parameters: Parameters)
}

public extension SceneHandler {
	var isReloadable: Bool {
		return false
	}

	func reload(_ viewController: UIViewController, parameters: Parameters) { }
}
