//
//  MockSceneHandler.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit
import NavigatorSwift

class MockSceneHandler: SceneHandler {
	var _name: SceneName = "MockScene"
	var _isReloadable = false
	var _view = UIViewController()
	var reloaded = false

	var name: SceneName {
		return _name
	}

	var isReloadable: Bool {
		return _isReloadable
	}

	func view(with parameters: Parameters) -> UIViewController {
		return _view
	}

	func reload(_ viewController: UIViewController, parameters: Parameters) {
		reloaded = true
	}
}
