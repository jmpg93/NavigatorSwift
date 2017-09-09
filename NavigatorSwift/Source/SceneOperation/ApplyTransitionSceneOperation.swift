//
//  ApplyTransitionSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ApplyTransitionSceneOperation: VisibleViewControllerFindable {
	fileprivate let transitionDelegate: UIViewControllerTransitioningDelegate
	fileprivate let toViewController: UIViewController

	init(transitionDelegate: UIViewControllerTransitioningDelegate, toViewController: UIViewController) {
		self.transitionDelegate = transitionDelegate
		self.toViewController = toViewController
	}
}

extension ApplyTransitionSceneOperation {
	func execute(with completion: CompletionBlock?) {
		toViewController.transitioningDelegate = transitionDelegate
	}
}
