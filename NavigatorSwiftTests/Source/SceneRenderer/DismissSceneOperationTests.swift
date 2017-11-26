//
//  DismissSceneOperationTests.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 19/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest


class DismissSceneOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: DismissSceneOperation!
}

// MARK: Tests

extension DismissSceneOperationTests {
	func testGivenRootSceneDisplayedModally_execute_dismissScene() {
		//given
		let rootViewMock = givenMockViewController(isDisplayedModally: true, sceneName: Constants.anyScene)
		sut = givenSUT(sceneName: Constants.anyScene, animated: true, modalView: rootViewMock)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(rootViewMock.dismissed)
	}

	func testGivenRootSceneNotDisplayedModally_execute_doNotDismissScene() {
		//given
		let rootViewMock = givenMockViewController(isDisplayedModally: false, sceneName: Constants.anyScene)
		var executed = false
		sut = givenSUT(sceneName: Constants.anyScene, animated: true, modalView: rootViewMock)

		// when
		sut.execute {
			executed = true
		}

		// then
		XCTAssertTrue(executed)
		XCTAssertFalse(rootViewMock.dismissed)
	}

	func testGivenRootSceneAndSceneDisplayedModally_execute_dismissScene() {
		//given
		let rootViewMock = givenMockViewController(isDisplayedModally: true, sceneName: Constants.anyScene)
		let otherViewMock = givenMockViewController(isDisplayedModally: true, sceneName: Constants.anyOtherScene)
		sut = givenSUT(sceneName: Constants.anyScene, animated: true, modalView: rootViewMock)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(rootViewMock.dismissed)
		XCTAssertFalse(otherViewMock.dismissed)
	}
}

// MARK: Helpers

extension DismissSceneOperationTests {
	func givenMockViewController(isDisplayedModally: Bool, sceneName: SceneName) -> MockViewController {
		let mockView = MockViewController()
		mockView.sceneName = sceneName.value
		mockView._isBeingDisplayedModally = isDisplayedModally
		return mockView
	}

	func givenSUT(sceneName: SceneName, animated: Bool, modalView: UIViewController) -> DismissSceneOperation {
		let mockNavigationController = MockNavigationController(viewControllers: [modalView])
		let mockSceneRenderer = givenMockSceneRenderer(window: MockWindow(), root: mockNavigationController)
		return DismissSceneOperation(sceneName: sceneName, animated: animated, renderer: mockSceneRenderer)
	}
}
