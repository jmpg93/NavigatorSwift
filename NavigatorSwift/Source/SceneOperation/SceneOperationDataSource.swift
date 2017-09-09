//
//  SceneOperationDataSource.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol SceneOperationDataSource {
	func installOperation(scene: Scene, renderer: SceneRenderer) -> SceneOperation
	func addOperation(scene: Scene, renderer: SceneRenderer) -> SceneOperation
	func changeOperation(scene: Scene, renderer: SceneRenderer) -> SceneOperation
	func dismissOperation(scene: Scene, renderer: SceneRenderer) -> SceneOperation
	func recycleSceneOperation(scene: Scene, renderer: SceneRenderer) -> SceneOperation
}

extension SceneOperationDataSource {
	func installOperation(scene: Scene, renderer: SceneRenderer) -> SceneOperation {
		return InstallSceneOperation(scene: scene, renderer: renderer)
	}

	func addOperation(scenes: [Scene], rootViewController: UIViewController) -> SceneOperation {
		return AddScenesOperation(scenes: scenes, rootViewController: rootViewController)
	}

	func changeOperation(scenes: [Scene], renderer: SceneRenderer) -> SceneOperation {
		return ChangeScenesOperation(scenes: scenes, sceneRendeded: renderer)
	}

	func dismissAllOperation(rootViewController: UIViewController, animated: Bool) -> SceneOperation {
		return DismisAllViewControllerOperation(rootViewController: rootViewController, animated: animated)
	}

	func recycleSceneOperation(scenes: [Scene], visibleViewController: UIViewController) -> SceneOperation {
		return RenderSceneOperation(scenes: scenes, visibleViewController: visibleViewController)
	}
}
