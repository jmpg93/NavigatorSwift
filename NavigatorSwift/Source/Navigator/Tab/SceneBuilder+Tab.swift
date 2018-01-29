//
//  SceneBuilder+Tab.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 25/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public extension SceneBuilder where T: TabNavigator {
	func tab(_ sceneName: SceneName, parameters: Parameters = [:]) {
		add(context: SceneContext(sceneName: sceneName, parameters: parameters, type: .none, isAnimated: true))
	}
}
