//
//  MockScene.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit
@testable import NavigatorSwift

class MockScene: Scene {
	var _type = ScenePresentationType.push
	var _view = UIViewController()
	var configured = false

	init(sceneHandler: SceneHandler, type: ScenePresentationType) {
		super.init(sceneHandler: sceneHandler,
				   parameters: [:],
				   type: type,
				   animated: false)
	}

	override func view() -> UIViewController {
		return _view
	}

	override func configure(_ viewController: UIViewController) {
		configured = true
	}
}
