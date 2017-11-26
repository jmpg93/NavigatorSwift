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
	func testRootSceneDisplayedModally_dismissRootSceneAnimated_dismissScene() {
		//given
		let rootViewMock = givenMockViewController(isDisplayedModally: true)
		sut = givenSUT(animated: true, modalView: rootViewMock)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(rootViewMock.dismissed)
	}

	func testRootSceneNotDisplayedModally_dismissRootSceneAnimated_dismissScene() {
		//given
		let rootViewMock = givenMockViewController(isDisplayedModally: false)
		var executed = false
		sut = givenSUT(animated: true, modalView: rootViewMock)

		// when
		sut.execute {
			executed = true
		}

		// then
		XCTAssertTrue(executed)
		XCTAssertFalse(rootViewMock.dismissed)
	}

	func testRootSceneDisplayedModally_dismissOtherSceneAnimated_doNotDismissScene() {
		//given
		let rootViewMock = givenMockViewController(isDisplayedModally: true)
		let otherViewMock = givenMockViewController(isDisplayedModally: true)
		sut = givenSUT(animated: true, modalViews: [rootViewMock, otherViewMock])

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(rootViewMock.dismissed)
		XCTAssertFalse(otherViewMock.dismissed)
	}
}

// MARK: Helpers

extension DismissFirstSceneOperationTests {
	func givenMockViewController(isDisplayedModally: Bool) -> MockViewController {
		let viewMock = MockViewController()
		viewMock._isBeingDisplayedModally = isDisplayedModally
		return viewMock
	}

	func givenSUT(animated: Bool, modalView: UIViewController) -> DismissFirstSceneOperation {
		let nav = UINavigationController(rootViewController: modalView)
		let sceneRendererMock = givenMockSceneRenderer(window: MockWindow(), root: nav)
		return DismissFirstSceneOperation(animated: animated, renderer: sceneRendererMock)
	}

	func givenSUT(animated: Bool, modalViews: [UIViewController]) -> DismissFirstSceneOperation {
		let nav = UINavigationController(rootViewController: modalViews.first!)
		nav.present(modalViews.last!, animated: false, completion: nil)
		let sceneRendererMock = givenMockSceneRenderer(window: MockWindow(), root: nav)
		return DismissFirstSceneOperation(animated: animated, renderer: sceneRendererMock)
	}
}
