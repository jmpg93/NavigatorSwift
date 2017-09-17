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
		scene.transition = transition
		renderer.add(scenes: [scene]).execute(with: completion)
	}
}

