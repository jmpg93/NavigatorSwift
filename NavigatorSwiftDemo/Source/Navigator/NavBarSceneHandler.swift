//
//  NavBarSceneHandler.swift
//  NavigatorSwiftDemo
//
//  Created by Jose Maria Puerta on 26/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift

extension SceneName {
	static let navBar: SceneName = "NavBar"
}

class NavBarSceneHandler: SceneHandler {
	var name: SceneName {
		return .navBar
	}

	func view(with parameters: Parameters = [:]) -> UIViewController {
		return NavBar()
	}
}
