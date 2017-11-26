//
//  ReloadOperationTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 26/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//


@testable import NavigatorSwift
import XCTest

class ReloadSceneOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: ReloadSceneOperation!
}

extension ReloadSceneOperationTests {
	func testRootWithMatchingScene_execute_reloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyScene)
		let mockSceneRenderer = givenSceenRenderer(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .reload)
		sut = ReloadSceneOperation(scene: mockScene, renderer: mockSceneRenderer)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertTrue(sceneHandler.reloaded)
	}

	func testRootWithNotMatchingScene_execute_doNotReloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyOtherScene)
		let mockSceneRenderer = givenSceenRenderer(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .reload)
		sut = ReloadSceneOperation(scene: mockScene, renderer: mockSceneRenderer)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertFalse(sceneHandler.reloaded)
	}

	func testNoRoot_execute_doNotReloadViewController() {
		//given
		let mockSceneRenderer = givenMockSceneRenderer(window: MockWindow(), root: MockNavigationController())
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .reload)
		sut = ReloadSceneOperation(scene: mockScene, renderer: mockSceneRenderer)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertFalse(sceneHandler.reloaded)
	}
}

extension ReloadSceneOperationTests {
	func givenMockViewController(with sceneName: SceneName) -> MockViewController {
		let mockViewController = MockViewController()
		mockViewController.sceneName = sceneName.value
		return mockViewController
	}

	func givenSceenRenderer(root: UIViewController) -> MockSceneRenderer {
		let mockNavigationController = MockNavigationController(viewControllers: [root])
		return givenMockSceneRenderer(window: MockWindow(), root: mockNavigationController)
	}
}




