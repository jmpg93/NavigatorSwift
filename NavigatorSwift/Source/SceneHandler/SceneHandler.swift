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
	var viewControllerClass: AnyClass { get }
	var isViewControllerRecyclable: Bool { get }

	func buildViewController(with parameters: Parameters) -> UIViewController
	func reload(_ viewController: UIViewController, parameters: Parameters)
}
