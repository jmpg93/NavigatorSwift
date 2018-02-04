//
//  PopSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

struct PopSceneOperation {
	private let popToRoot: Bool
	private let animated: Bool
	private let manager: SceneOperationManager

	init(toRoot popToRoot: Bool, animated: Bool, manager: SceneOperationManager) {
		self.popToRoot = popToRoot
		self.animated = animated
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension PopSceneOperation: InterceptableSceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[PopSceneOperation] Executing operation")

		guard let rootViewController = manager.rootViewController else {
			logTrace("[PopSceneOperation] No root view controller found")
			completion?()
			return
		}

		let visibleViewController = manager.visible(from: rootViewController)

		guard let navigationController = visibleViewController.navigationController else {
			logTrace("[PopSceneOperation] No navigation controller found in the most visible view controller \(visibleViewController)")
			completion?()
			return
		}

		if popToRoot {
			logTrace("[PopSceneOperation] Popping to root")
			navigationController.popToRootViewController(animated: animated)
		} else {
			navigationController.popViewController(animated: animated)
		}

		let animationTime: TimeInterval = animated ? UIView.defaultAnimationDuration : 0.0

		DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
			completion?()
		}
	}

	func context() -> InterceptorContext {
		guard let sceneName = manager.rootViewController?.sceneName else {
			return .empty
		}

		let from = manager.state(from: manager.rootViewController)
		let to = from.droping(top: .push)

		return InterceptorContext(from: from, to: to)
	}
}
