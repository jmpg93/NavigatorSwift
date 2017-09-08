//
//  DismissAllViewControllerOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class DismisAllViewControllerOperation: SceneOperation {
	fileprivate let rootViewController: UIViewController
	fileprivate let animated: Bool

	init(rootViewController: UIViewController, animated: Bool) {
		self.rootViewController = rootViewController
		self.animated = animated
	}
}

// MARK: SceneOperation methods

extension DismisAllViewControllerOperation  {
	func execute(with completion: CompletionBlock?) {
		rootViewController.dismiss(animated: animated, completion: completion)

		if !animated {
			completion?()
		}
	}
}
