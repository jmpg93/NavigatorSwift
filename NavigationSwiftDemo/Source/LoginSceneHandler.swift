//
//  LoginSceneHandler.swift
//  NavigationSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift

extension SceneName {
	static let login: SceneName = SceneName("Login")
}

class LoginSceneHandler: SceneHandler {
	var name: SceneName {
		return .login
	}

	func buildViewController(with parameters: Parameters) -> UIViewController {
		let vc = UIViewController()
		vc.view.backgroundColor = .red
		return vc
	}
}

class LoginSceneRegisterer: SceneHandlerRegistrable {
	let sceneHandler = LoginSceneHandler()
	
	func sceneHandlersToRegister() -> [SceneHandler] {
		return [sceneHandler]
	}
}
