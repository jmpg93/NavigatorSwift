//
//  HierarchyStateSearchable.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 4/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol HierarchyStateSearchable: VisibleViewControllerFindable {
	func state(from viewController: UIViewController?) -> [SceneState]
}

// MARK: Default implementation

public extension HierarchyStateSearchable {
	func state(from viewController: UIViewController?) -> [SceneState] {
		var _next = viewController
		var views: [UIViewController] = []

		while let next = _next {
			views.append(next)
			_next = self.next(before: next)
		}

		return views
			.lazy
			.map { ($0.sceneName, $0.scenePresentationType) }
			.map { $0 == nil ? nil : (SceneName($0!), $1) }
			.flatMap { $0 }
			.map(SceneState.init)
	}

	func firstViewController(matching sceneName: SceneName) -> UIViewController? {
		var _next: UIViewController? = nil

		while let next = _next {
			if next.sceneName == sceneName.value {
				return next
			} else {
				_next = self.next(before: next)
			}
		}

		return nil
	}
}

// MARK: Handy method

extension HierarchyStateSearchable where Self: SceneOperationManager {
	var currentState: [SceneState] {
		return state(from: rootViewController)
	}
}
