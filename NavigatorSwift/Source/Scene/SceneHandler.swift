//
//  SceneHandler.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

protocol SceneHandler: class {
	func name() -> String
	func viewControllerClass() -> AnyClass
	func buildViewController(with parameters: [String: Any]) -> UIViewController
	func isViewControllerRecyclable() -> Bool
	func reload(_ viewController: UIViewController, parameters: [String: Any])
}
