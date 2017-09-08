//
//  InstallSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class InstallSceneOperation: SceneOperation {
	fileprivate let scene: Scene
	fileprivate let renderer: SceneRenderer

	init(scene: Scene, renderer: SceneRenderer) {
		self.scene = scene
		self.renderer = renderer
	}
}

extension InstallSceneOperation {
	func execute(with completion: CompletionBlock?) {
		let buildedViewController = scene.sceneHandler._buildViewController(with: scene.parameters)

		if let buildedViewController = buildedViewController as? ViewControllerContainer {
			renderer.viewControllerContainer = buildedViewController
		} else {
			let navigationBarContainer = NavigationBarContainer()
			renderer.viewControllerContainer = navigationBarContainer

			let navigationController = navigationBarContainer.visibleNavigationController
			navigationController.pushViewController(buildedViewController, animated: false)
		}

		renderer.window.rootViewController = renderer.rootViewController
		renderer.window.makeKeyAndVisible()

		completion?()
	}
}
