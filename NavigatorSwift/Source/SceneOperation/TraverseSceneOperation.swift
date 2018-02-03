//
//  TraverseSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 30/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public typealias SceneViewState = (SceneName, ScenePresentationType)
public typealias TraverseBlock = ([SceneViewState]) -> Void

public struct TraverseSceneOperation: NextViewControllerFindable {
	private let traverseBlock: ([SceneViewState]) -> Void
	private let manager: SceneOperationManager

	public init(traverseBlock: @escaping TraverseBlock, manager: SceneOperationManager) {
		self.traverseBlock = traverseBlock
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension TraverseSceneOperation: SceneOperation {
	public func execute(with completion: CompletionBlock?) {
		logTrace("[TraverseSceneOperation] Executing operation")

		var _next = manager.rootViewController
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

		traverseBlock(scenes)
		completion?()
	}
}
