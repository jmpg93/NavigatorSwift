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
	func testReloadableRootWithMatchingScene_execute_reloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyScene)
		let mockSceneOperationManager = givenSceenRenderer(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .none, isReloadable: true)
		sut = ReloadSceneOperation(scene: mockScene, manager: mockSceneOperationManager)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertTrue(sceneHandler.reloaded)
	}

	func testNotReloadableRootWithMatchingScene_execute_reloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyScene)
		let mockSceneOperationManager = givenSceenRenderer(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .none, isReloadable: false)
		sut = ReloadSceneOperation(scene: mockScene, manager: mockSceneOperationManager)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertFalse(sceneHandler.reloaded)
	}

	func testRootWithNotMatchingScene_execute_doNotReloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyOtherScene)
		let mockSceneOperationManager = givenSceenRenderer(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .none)
		sut = ReloadSceneOperation(scene: mockScene, manager: mockSceneOperationManager)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertFalse(sceneHandler.reloaded)
	}

	func testNoRoot_execute_doNotReloadViewController() {
		//given
		let mockSceneOperationManager = givenMockSceneOperationManager(window: MockWindow(), root: MockNavigationController())
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .none)
		sut = ReloadSceneOperation(scene: mockScene, manager: mockSceneOperationManager)

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

	func givenSceenRenderer(root: UIViewController) -> MockSceneOperationManager {
		let mockNavigationController = MockNavigationController(viewControllers: [root])
		return givenMockSceneOperationManager(window: MockWindow(), root: mockNavigationController)
	}
}




