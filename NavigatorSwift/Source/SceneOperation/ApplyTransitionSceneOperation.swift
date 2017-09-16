//
//  ApplyTransitionSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class ApplyTransitionSceneOperation: NSObject, SceneOperation, VisibleViewControllerFindable {
	fileprivate let transition: Transition
	fileprivate let scene: Scene
	fileprivate let renderer: SceneRenderer

	init(transition: Transition, to scene: Scene, renderer: SceneRenderer) {
		self.transition = transition
		self.scene = scene
		self.renderer = renderer
	}
}

extension ApplyTransitionSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let view = scene.sceneHandler._buildViewController(with: scene.parameters)
		view.transitioningDelegate = self
		view.modalPresentationStyle = transition.modalPresentationStyle

		renderer
			.visibleNavigationController
			.topViewController?
			.present(view, animated: true) { completion?() }
	}
}

extension ApplyTransitionSceneOperation: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController,
	                         presenting: UIViewController,
	                         source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
}

