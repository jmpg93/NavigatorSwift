	//
//  SceneOperationTests.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class SceneOperationTests: XCTestCase {
	public enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
	}

	lazy var sceneRenderer: SceneRenderer = SceneRenderer(window: self.mockWindow, viewControllerContainer: self.mockViewControllerContainer)

	lazy var mockViewController: MockViewController = MockViewController()
	lazy var mockWindow: MockWindow = MockWindow()
	lazy var mockViewControllerContainer: MockViewControllerContainer = MockViewControllerContainer()
	lazy var mockSceneHandler: MockSceneHandler = MockSceneHandler()
	lazy var mockSceneMatcher: MockSceneMatcher = MockSceneMatcher()
	lazy var mockScene: MockScene = MockScene(sceneHandler: self.mockSceneHandler, parameters: [:], type: .modal, animated: false)

	lazy var mockScenes: [MockScene] = [
		MockScene(sceneHandler: self.mockSceneHandler, parameters: [:], type: .modal, animated: false)
	]
}

extension SceneOperationTests {
	func givenStubbedWindow(root: UIViewController = Constants.anyView) {
		stub(mockWindow) { stub in
			when(stub.rootViewController.set(any())).thenDoNothing()
			when(stub.rootViewController.get).thenReturn(root)
			when(stub.makeKeyAndVisible()).then(Constants.anyBlock)
		}
	}

	func givenStubbedViewControllerContainer(root: UIViewController = Constants.anyView) {
		stub(mockViewControllerContainer) { stub in
			when(stub.rootViewController.get).thenReturn(root)
		}
	}

	func givenStubbedSceneHandler(builded: UIViewController = Constants.anyView) {
		stub(mockSceneHandler) { stub in
			when(stub.name.get).thenReturn(Constants.anyScene)
			when(stub.buildViewController(with: any())).thenReturn(builded)
		}
	}

	func givenMockScene(name: SceneName = Constants.anyScene,
	                    view: UIViewController = Constants.anyView,
	                    type: ScenePresentationType = .modal,
	                    isViewControllerRecyclable: Bool = false) -> MockScene {
		stub(mockSceneHandler) { stub in
			when(stub.buildViewController(with: any())).thenReturn(view)
			when(stub.name.get).thenReturn(name)
			when(stub.isViewControllerRecyclable.get).thenReturn(isViewControllerRecyclable)
		}

		return MockScene(sceneHandler: mockSceneHandler,
		                 parameters: [:],
		                 type: type,
		                 animated: false)
	}

	@discardableResult
	func givenRootScene() -> Scene {
		let rootScene = givenMockScene()
		InstallSceneOperation(scene: rootScene, renderer: sceneRenderer).execute(with: nil)
		return rootScene
	}
}
