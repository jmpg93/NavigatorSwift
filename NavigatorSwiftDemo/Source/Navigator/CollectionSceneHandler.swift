//
//  CollectionSceneHandler.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift
import UIKit

extension SceneName {
	static let collection: SceneName = "Collection"
}

class CollectionSceneHandler: SceneHandler {
	enum Parameter {
		static let stateLabel = "stateLabel"
	}

	var name: SceneName {
		return .collection
	}

	func view(with parameters: Parameters = [:]) -> UIViewController {
		let view = Collection.loadFromStoryBoard()
		if let state = parameters[Parameter.stateLabel] as? String {
			view.stateText = state
		}
		view.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
		view.title = "Collection"
		return view
	}
}
