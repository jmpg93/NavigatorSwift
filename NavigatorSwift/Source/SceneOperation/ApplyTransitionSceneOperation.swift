//
//  ApplyTransitionSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ApplyTransitionSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let delegate: UIViewControllerTransitioningDelegate
	fileprivate let toViewController: UIViewController
	fileprivate let renderer: SceneRenderer

	init(delegate: UIViewControllerTransitioningDelegate, toViewController: UIViewController, renderer: SceneRenderer) {
		self.delegate = delegate
		self.toViewController = toViewController
		self.renderer = renderer
	}
}

extension ApplyTransitionSceneOperation {
	func execute(with completion: CompletionBlock?) {
		toViewController.transitioningDelegate = delegate
	}
}
