//
//  PopSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class PopSceneOperation: VisibleViewControllerFindable {
	fileprivate let popToRoot: Bool
	fileprivate let rootViewController: UIViewController
	fileprivate let animated: Bool

	init(toRoot popToRoot: Bool, rootViewController: UIViewController, animated: Bool) {
		self.popToRoot = popToRoot
		self.rootViewController = rootViewController
		self.animated = animated
	}
}

extension PopSceneOperation {
	func execute(with completion: CompletionBlock?) -> [UIViewController]? {
		var poppedViewControllers: [UIViewController]? = []

		let visibleViewController = self.visibleViewController(from: rootViewController)

		guard let navigationController = visibleViewController.navigationController else {
			return poppedViewControllers
		}

		if popToRoot {
			poppedViewControllers = navigationController.popToRootViewController(animated: animated)
		} else if let poppedViewController = navigationController.popViewController(animated: animated) {
			poppedViewControllers = [poppedViewController]
		}

		let animationTime: TimeInterval = animated ? UIView.defaultAnimationDuration : 0.0

		DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
			completion?()
		}

		return poppedViewControllers
	}
}
