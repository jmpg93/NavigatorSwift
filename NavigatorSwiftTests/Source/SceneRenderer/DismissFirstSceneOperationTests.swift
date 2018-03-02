//
//  DismissFirstSceneOperationTests.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 19/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class DismissFirstSceneOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: DismissFirstSceneOperation!
}

// MARK: Tests

extension DismissFirstSceneOperationTests {
	func testGivenSceneDisplayedModally_execute_dismissScene() {
		//given
		let modalView = givenMockViewController(isDisplayedModally: true)
		sut = givenSUT(animated: true, modalView: modalView)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(modalView.dismissed)
	}

	func testGivenScenesDisplayedModally_execute_dismissLastScene() {
		//given
		let modalView = givenMockViewController(isDisplayedModally: true)
		let otherModalView = givenMockViewController(isDisplayedModally: true)
		sut = givenSUT(animated: true, modalViews: [modalView, otherModalView])

		// when
		sut.execute(with: nil)

		// then
		XCTAssertFalse(modalView.dismissed)
		XCTAssertTrue(otherModalView.dismissed)
	}
}

// MARK: Helpers

extension DismissFirstSceneOperationTests {
	func givenMockViewController(isDisplayedModally: Bool) -> MockViewController {
		let viewMock = MockViewController()
		viewMock._isBeingDisplayedModally = isDisplayedModally
		return viewMock
	}

	func givenSUT(animated: Bool, modalView: MockViewController) -> DismissFirstSceneOperation {
		return givenSUT(animated: animated, modalViews: [modalView])
	}

	func givenSUT(animated: Bool, modalViews: [MockViewController]) -> DismissFirstSceneOperation {
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
		return DismissFirstSceneOperation(animated: animated,
										  manager: manager)
	}
}
