//
//  DismissAllOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct DismissAllOperation {
	private let animated: Bool
	private let manager: SceneOperationManager

	init(animated: Bool, manager: SceneOperationManager) {
		self.animated = animated
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension DismissAllOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[DismissAllOperation] Executing operation")

		guard let rootViewController = manager.rootViewController else {
			logTrace("[DismissAllOperation] No root view controller found")
			completion?()
			return
		}

		rootViewController.dismiss(animated: animated, completion: completion)

		if !animated {
			completion?()
		}
	}

	func context(from: [SceneState]) -> SceneOperationContext {
		return SceneOperationContext(currentState: from, targetState: from.dropping(from: .modal))
	}
}
