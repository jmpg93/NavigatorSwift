//
//  BlueSceneHandler.swift
//  NavigatorSwiftDemo
//
//  Created by Jose Maria Puerta on 25/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift

extension SceneName {
	static let blue: SceneName = "Blue"
}

class BlueSceneHandler: SceneHandler {
	var name: SceneName {
		return .blue
	}

	func view(with parameters: Parameters = [:]) -> UIViewController {
		let view = Collection.loadFromStoryBoard()
		view.color = .blue

		if let state = parameters[CollectionSceneHandler.Parameter.stateLabel] as? String {
			view.stateText = state
		}
		view.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
		view.title = "Blue"
		return view
	}
}
