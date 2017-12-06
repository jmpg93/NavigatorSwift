//
//  MockSceneOperationManager.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
@testable import NavigatorSwift

class MockSceneOperationManager: SceneOperationManager {
	var _setScenesOperation: SceneOperation = MockSceneOperation()
	override func set(scenes: [Scene]) -> SceneOperation {
		return _setScenesOperation
	}

	var _addScenesOperation: SceneOperation = MockSceneOperation()
	override func add(scenes: [Scene]) -> SceneOperation {
		return _addScenesOperation
	}

	var _popOperation: SceneOperation = MockSceneOperation()
	override func pop(animated: Bool) -> SceneOperation {
		return _popOperation
	}

	var _popToRootOperation: SceneOperation = MockSceneOperation()
	override func popToRoot(animated: Bool) -> SceneOperation {
		return _popToRootOperation
	}

	var _dismissAllOperation: SceneOperation = MockSceneOperation()
	override func dismissAll(animated: Bool) -> SceneOperation {
		return _dismissAllOperation
	}

	var _dismissOperation: SceneOperation = MockSceneOperation()
	override func dismiss(animated: Bool) -> SceneOperation {
		return _dismissOperation
	}

	var _dismissSceneOperation: SceneOperation = MockSceneOperation()
	override func dismiss(sceneName: SceneName, animated: Bool) -> SceneOperation {
		return _dismissSceneOperation
	}

	var _recycleOperation: SceneOperation = MockSceneOperation()
	override func recycle(scenes: [Scene]) -> SceneOperation {
		return _recycleOperation
	}

	var _rootOperation: SceneOperation = MockSceneOperation()
	override func root(scene: Scene) -> SceneOperation {
		return _rootOperation
	}

	var _transitionOperation: SceneOperation = MockSceneOperation()
	override func transition(_ transition: Transition, to scene: Scene) -> SceneOperation {
		return _transitionOperation
	}

	var _popoverOperation: SceneOperation = MockSceneOperation()
	override func popover(_ popover: Popover, to scene: Scene) -> SceneOperation {
		return _popoverOperation
	}
}
