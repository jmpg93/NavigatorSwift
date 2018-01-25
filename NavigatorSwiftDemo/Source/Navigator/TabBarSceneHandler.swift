//
//  TabBarSceneHandler.swift
//  NavigatorSwiftDemo
//
//  Created by Jose Maria Puerta on 25/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift

extension SceneName {
	static let tabBar: SceneName = "TabBar"
}

class TabBarSceneHandler: SceneHandler {
	var name: SceneName {
		return .tabBar
	}

	func view(with parameters: Parameters = [:]) -> UIViewController {
		return TabBar()
	}
}
