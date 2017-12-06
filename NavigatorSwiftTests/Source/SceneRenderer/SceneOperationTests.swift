//
//  SceneOperationTests.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest


class SceneOperationTests: XCTestCase {
	public enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
	}
}

extension SceneOperationTests {
	func givenMockViewControllerContainer(root: UINavigationController) -> MockViewControllerContainer {
		let mockViewControllerContainer = MockViewControllerContainer()
		mockViewControllerContainer._rootViewController = root
		mockViewControllerContainer._firstLevelNavigationControllers = [root]
		mockViewControllerContainer._visibleNavigationController = root
		return mockViewControllerContainer
	}

	func givenMockSceneOperationManager(window: UIWindow, root: UINavigationController, scene: SceneName? = nil) -> MockSceneOperationManager {
		if let scene = scene {
			root.visibleViewController!.sceneName = scene.value
		}

		let mockContainer = givenMockViewControllerContainer(root: root)
		return MockSceneOperationManager(window: window, viewControllerContainer: mockContainer)
	}

	func givenMockSceneHandler(name: SceneName,
	                           view: UIViewController,
	                           isReloadable: Bool = false) -> MockSceneHandler {
		let mockSceneHandler = MockSceneHandler()
		mockSceneHandler._name = name
		mockSceneHandler._isReloadable = isReloadable
		mockSceneHandler._view = view
		return mockSceneHandler
	}

	func givenMockScene(name: SceneName,
	                    view: UIViewController,
	                    type: ScenePresentationType,
	                    isReloadable: Bool = false) -> MockScene {
		view.sceneName = name.value
		let mockSceneHandler = givenMockSceneHandler(name: name,
		                                             view: view,
		                                             isReloadable: isReloadable)

		let mockScene = MockScene(sceneHandler: mockSceneHandler, type: type)
		mockScene._view = view

		return mockScene
	}

	func givenMockScenes() -> [Scene] {
		return [
			givenMockScene(name: Constants.anyScene, view: Constants.anyView, type: .push),
			givenMockScene(name: Constants.anyOtherScene, view: Constants.anyOtherView, type: .push)
		]
	}

	func givenMockOperation() -> MockSceneOperation {
		return MockSceneOperation()
	}
}
