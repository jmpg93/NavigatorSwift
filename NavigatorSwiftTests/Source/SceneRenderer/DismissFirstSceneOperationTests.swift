//
//  DismissFirstSceneOperationTests.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 19/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class PopOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: PopSceneOperation!
}

// MARK: Tests

extension PopOperationTests {
	func testGivenRootNavigation_execute_rootNavigationPopped() {
		//given
		let rootNavigation = MockNavigationController(viewControllers: [MockViewController()])
		sut = givenSUT(toRoot: false, root: rootNavigation)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(rootNavigation.popped)
	}

	func testGivenRootNavigation_executeToRoot_rootNavigationPoppedToRoot() {
		//given
		let rootNavigation = MockNavigationController(viewControllers: [MockViewController()])
		sut = givenSUT(toRoot: true, root: rootNavigation)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(rootNavigation.poppedToRoot)
	}

	func testGivenRootNavigationWithNoViewController_execute_rootNavigationPoppedToRoot() {
		//given
		let rootNavigation = MockNavigationController()
		sut = givenSUT(toRoot: false, root: rootNavigation)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertFalse(rootNavigation.popped)
	}

	func testGivenRootNavigationWithNoViewController_executeToRoot_rootNavigationPoppedToRoot() {
		//given
		let rootNavigation = MockNavigationController()
		sut = givenSUT(toRoot: true, root: rootNavigation)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertFalse(rootNavigation.poppedToRoot)
	}
}

// MARK: Helpers

extension PopOperationTests {
	func givenSUT(toRoot: Bool, root: UINavigationController) -> PopSceneOperation {
		let sceneRender = givenMockSceneRenderer(window: MockWindow(), root: root)
		return PopSceneOperation(toRoot: toRoot, animated: false, renderer: sceneRender)
	}
}
