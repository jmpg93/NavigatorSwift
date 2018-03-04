//
//  LoginSceneHandler.swift
//  NavigatorSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift

extension SceneName {
	static let red: SceneName = "Red"
}

class RedSceneHandler: SceneHandler {
	var name: SceneName {
		return .red
	}

	func view(with parameters: Parameters = [:]) -> UIViewController {
		let view = NavigatorFlowCollection.loadFromStoryBoard()
		view.color = .red

		if let state = parameters[CollectionSceneHandler.Parameter.stateLabel] as? String {
			view.stateText = state
		}
		view.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
		view.title = "Red"
		return view
	}
}
