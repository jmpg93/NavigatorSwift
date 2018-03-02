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
	func testGivenModalScene_execute_dismissScene() {
		//given
		let modalView = givenMockViewController(isDisplayedModally: true, sceneName: Constants.anyScene)
		sut = givenSUT(sceneName: Constants.anyScene, animated: true, modalView: modalView)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(modalView.dismissed)
	}

	func testGivenModalScenes_execute_dismissScene() {
		//given
		let modalView = givenMockViewController(isDisplayedModally: true, sceneName: Constants.anyScene)
		let otherModalView = givenMockViewController(isDisplayedModally: true, sceneName: Constants.anyOtherScene)
		sut = givenSUT(sceneName: Constants.anyOtherScene, animated: true, modalViews: [modalView, otherModalView])

		// when
		sut.execute(with: nil)

		// then
		XCTAssertFalse(modalView.dismissed)
		XCTAssertTrue(otherModalView.dismissed)
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

	func givenSUT(sceneName: SceneName, animated: Bool, modalView: MockViewController) -> DismissSceneOperation {
		return givenSUT(sceneName: sceneName, animated: animated, modalViews: [modalView])
	}

	func givenSUT(sceneName: SceneName, animated: Bool, modalViews: [MockViewController]) -> DismissSceneOperation {
		let root = MockViewController()
		let container = MockViewControllerContainer()
		container._rootViewController = root
		container._visibleNavigationController = MockNavigationController(viewControllers: [root])

		var lasPresenting = root
		for modal in modalViews {
			lasPresenting.overridePresentedViewController = true
			lasPresenting._presentedViewController = modal
			modal.overridePresentingViewController = true
			modal._presentingViewController = lasPresenting
			lasPresenting = modal
		}

		let manager = givenMockSceneOperationManager(window: MockWindow(), container: container)
		return DismissSceneOperation(sceneName: sceneName,
									 animated: animated,
									 manager: manager)
	}
}
