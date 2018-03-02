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
		let manager = givenSceenOperationManager(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .select, isReloadable: true)
		sut = ReloadSceneOperation(scene: mockScene, manager: manager)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertTrue(sceneHandler.reloaded)
	}

	func testNotReloadableRootWithMatchingScene_execute_reloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyScene)
		let manager = givenSceenOperationManager(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .select, isReloadable: false)
		sut = ReloadSceneOperation(scene: mockScene, manager: manager)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertFalse(sceneHandler.reloaded)
	}

	func testRootWithNotMatchingScene_execute_doNotReloadViewController() {
		//given
		let root = givenMockViewController(with: Constants.anyOtherScene)
		let manager = givenSceenOperationManager(root: root)
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .select)
		sut = ReloadSceneOperation(scene: mockScene, manager: manager)

		//when
		sut.execute(with: nil)

		//then
		let sceneHandler = mockScene.sceneHandler as! MockSceneHandler
		XCTAssertFalse(sceneHandler.reloaded)
	}

	func testNoRoot_execute_doNotReloadViewController() {
		//given
		let manager = givenMockSceneOperationManager(window: MockWindow(), root: MockViewController())
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .select)
		sut = ReloadSceneOperation(scene: mockScene, manager: manager)

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

	func givenSceenOperationManager(root: MockViewController) -> MockSceneOperationManager {
		return givenMockSceneOperationManager(window: MockWindow(), root: root)
	}
}




