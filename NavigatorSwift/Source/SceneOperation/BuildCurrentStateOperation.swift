//
//  BuildCurrentStateOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 30/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public struct BuildCurrentStateOperation: NextViewControllerFindable {
	public typealias SceneViewState = (SceneName, ScenePresentationType)

	fileprivate let operation: ([SceneViewState]) -> Void
	fileprivate let manager: SceneOperationManager

	public init(operation: @escaping ([SceneViewState]) -> Void, manager: SceneOperationManager) {
		self.operation = operation
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension BuildCurrentStateOperation: SceneOperation {
	public func execute(with completion: CompletionBlock?) {
		var _next: UIViewController? = manager.viewControllerContainer.rootViewController
		var views: [UIViewController] = []

		while let next = _next {
			views.append(next)
			_next = self.next(before: next)
		}

		let scenes: [SceneViewState] = views
			.lazy
			.map { ($0.sceneName, $0.scenePresentationType) }
			.map { $0 == nil ? nil : (SceneName($0!), $1) }
			.flatMap { $0 }

		operation(scenes)
		completion?()
	}
}
