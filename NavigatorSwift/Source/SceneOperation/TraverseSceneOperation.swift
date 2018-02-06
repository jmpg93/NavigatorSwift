//
//  TraverseSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 30/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public typealias TraverseBlock = ([ScenePresentationState]) -> Void

public struct TraverseSceneOperation {
	private let traverseBlock: TraverseBlock
	private let manager: SceneOperationManager

	public init(traverseBlock: @escaping TraverseBlock, manager: SceneOperationManager) {
		self.traverseBlock = traverseBlock
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension TraverseSceneOperation: InterceptableSceneOperation {
	public func execute(with completion: CompletionBlock?) {
		logTrace("[TraverseSceneOperation] Executing operation")

		let state = manager.state(from: manager.rootViewController)

		traverseBlock(state)
		completion?()
	}

	public func context(from: [SceneState]) -> SceneOperationContext {
		return SceneOperationContext(from: from, to: from)
	}
}
