//
//  MockSceneRenderer.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
@testable import NavigatorSwift

class MockSceneRenderer: SceneRenderer {
	var _setScenesOperation: SceneOperation = MockSceneOperation()
	var _addScenesOperation: SceneOperation = MockSceneOperation()
	var _popOperation: SceneOperation = MockSceneOperation()
	var _popToRootOperation: SceneOperation = MockSceneOperation()
	var _dismissOperation: SceneOperation = MockSceneOperation()
	var _dismissSceneOperation: SceneOperation = MockSceneOperation()
	var _dismissAllOperation: SceneOperation = MockSceneOperation()
	var _recycleOperation: SceneOperation = MockSceneOperation()
	var _installOperation: SceneOperation = MockSceneOperation()
	var _transitionOperation: SceneOperation = MockSceneOperation()
	var _popoverOperation: SceneOperation = MockSceneOperation()

	override func set(scenes: [Scene]) -> SceneOperation {
		return _setScenesOperation
	}

	override func add(scenes: [Scene]) -> SceneOperation {
		return _addScenesOperation
	}

	override func pop(animated: Bool) -> SceneOperation {
		return _popOperation
	}

	override func popToRoot(animated: Bool) -> SceneOperation {
		return _popToRootOperation
	}

	override func dismissAll(animated: Bool) -> SceneOperation {
		return _dismissAllOperation
	}

	override func dismiss(animated: Bool) -> SceneOperation {
		return _dismissOperation
	}

	override func dismiss(sceneName: SceneName, animated: Bool) -> SceneOperation {
		return _dismissSceneOperation
	}

	override func recycle(scenes: [Scene]) -> SceneOperation {
		return _recycleOperation
	}

	override func root(scene: Scene) -> SceneOperation {
		return _installOperation
	}

	override func transition(_ transition: Transition, to scene: Scene) -> SceneOperation {
		return _transitionOperation
	}

	override func popover(_ popover: Popover, to scene: Scene) -> SceneOperation {
		return _popoverOperation
	}
}
