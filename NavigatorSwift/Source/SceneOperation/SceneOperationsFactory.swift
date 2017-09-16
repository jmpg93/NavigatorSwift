//
//  SceneOperationDataSource.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol SceneOperationsFactory {
	func installOperation(with renderer: SceneRenderer, scene: Scene) -> SceneOperation
	func addOperation(with renderer: SceneRenderer, scenes: [Scene]) -> SceneOperation
	func setOperation(with renderer: SceneRenderer, scenes: [Scene]) -> SceneOperation
	func dismissOperation(with renderer: SceneRenderer, scene: Scene, animated: Bool) -> SceneOperation
	func dismissFirstOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation
	func dismissAllOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation
	func popToRootOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation
	func popOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation
	func recycleOperation(with renderer: SceneRenderer, scenes: [Scene]) -> SceneOperation
	func transitionOperation(with renderer: SceneRenderer, scene: Scene, transition: Transition) -> SceneOperation
}

struct DefaultSceneOperationFactory: SceneOperationsFactory {
	func installOperation(with renderer: SceneRenderer, scene: Scene) -> SceneOperation {
		return InstallSceneOperation(scene: scene, renderer: renderer)
	}

	func addOperation(with renderer: SceneRenderer, scenes: [Scene]) -> SceneOperation {
		return AddSceneOperation(scenes: scenes, renderer: renderer)
	}

	func setOperation(with renderer: SceneRenderer, scenes: [Scene]) -> SceneOperation {
		return SetScenesOperation(scenes: scenes, renderer: renderer)
	}

	func dismissOperation(with renderer: SceneRenderer, scene: Scene, animated: Bool) -> SceneOperation {
		return DismissSceneOperation(scene: scene, animated: animated, renderer: renderer)
	}

	func dismissFirstOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation {
		return DismissFirstSceneOperation(animated: animated, renderer: renderer)
	}

	func dismissAllOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation {
		return DismissAllOperation(animated: animated, renderer: renderer)
	}

	func popToRootOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: true, animated: animated, renderer: renderer)
	}

	func popOperation(with renderer: SceneRenderer, animated: Bool) -> SceneOperation {
		return PopSceneOperation(toRoot: false, animated: animated, renderer: renderer)
	}

	func recycleOperation(with renderer: SceneRenderer, scenes: [Scene]) -> SceneOperation {
		return RecycleSceneOperation(scenes: scenes, renderer: renderer)
	}

	func transitionOperation(with renderer: SceneRenderer, scene: Scene, transition: Transition) -> SceneOperation {
		return ApplyTransitionSceneOperation(transition: transition, to: scene, renderer: renderer)
	}
}
