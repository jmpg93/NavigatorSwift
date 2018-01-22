//
//  DismissAllOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct DismissAllOperation {
	fileprivate let animated: Bool
	fileprivate let manager: SceneOperationManager

	init(animated: Bool, manager: SceneOperationManager) {
		self.animated = animated
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension DismissAllOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		manager.rootViewController.dismiss(animated: animated, completion: completion)

		if !animated {
			completion?()
		}
	}
}
