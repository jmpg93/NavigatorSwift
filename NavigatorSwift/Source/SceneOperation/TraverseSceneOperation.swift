//
//  TraverseSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 30/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public typealias SceneViewState = (name: SceneName, type: ScenePresentationType)
public typealias TraverseBlock = ([SceneViewState]) -> Void

public struct TraverseSceneOperation {
	private let traverseBlock: TraverseBlock
	private let manager: SceneOperationManager

	public init(traverseBlock: @escaping TraverseBlock, manager: SceneOperationManager) {
		self.traverseBlock = traverseBlock
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension TraverseSceneOperation: SceneOperation, StateSearchable {
	public func execute(with completion: CompletionBlock?) {
		logTrace("[TraverseSceneOperation] Executing operation")

		var _next = manager.rootViewController
		var views: [UIViewController] = []

		while let next = _next {
			views.append(next)
			_next = manager.next(before: next)
		}

		let scenes: [SceneViewState] = views
			.lazy
			.map { ($0.sceneName, $0.scenePresentationType) }
			.map { $0 == nil ? nil : (SceneName($0!), $1) }
			.flatMap { $0 }

		traverseBlock(scenes)
		completion?()
	}
}

protocol StateSearchable {
	func state(from viewController: UIViewController) -> [SceneViewState]
}

extension StateSearchable {
	func state(from viewController: UIViewController, manager: SceneOperationManager) -> [SceneViewState] {
		var _next = manager.rootViewController
		var views: [UIViewController] = []

		while let next = _next {
			views.append(next)
			_next = manager.next(before: next)
		}

		return views
			.lazy
			.map { ($0.sceneName, $0.scenePresentationType) }
			.map { $0 == nil ? nil : (SceneName($0!), $1) }
			.flatMap { $0 }
	}
}
