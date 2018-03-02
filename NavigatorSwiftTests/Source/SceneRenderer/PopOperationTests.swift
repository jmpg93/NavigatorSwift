//
//  PopOperationTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 23/11/17.
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
	func testGivenPushedView_execute_rootNavigationPopped() {
		//given
		let pushView = MockViewController()
		let root = givenRootWithPushedViews([pushView])
		sut = givenSUT(toRoot: false, root: root)

		// when
		sut.execute(with: nil)

		// then
		let navigationController = root.navigationController as! MockNavigationController
		XCTAssertTrue(navigationController.popped)
	}

	func testGivenPushedView_executeToRoot_rootNavigationPoppedToRoot() {
		//given
		let pushView = MockViewController()
		let root = givenRootWithPushedViews([pushView])
		sut = givenSUT(toRoot: true, root: root)

		// when
		sut.execute(with: nil)

		// then
		let navigationController = root.navigationController as! MockNavigationController
		XCTAssertTrue(navigationController.poppedToRoot)
	}
}

// MARK: Helpers

extension PopOperationTests {
	func givenRootWithPushedViews(_ views: [UIViewController]) -> MockViewController {
		let root = MockViewController()
		let nav = MockNavigationController(viewControllers: [root] + views)
		root.overrideNavigationController = true
		root._navigationController = nav
		return root
	}

	func givenSUT(toRoot: Bool, root: MockViewController) -> PopSceneOperation {
		let navigationController = root.navigationController!
		let container = MockViewControllerContainer()
		container._rootViewController = root
		container._visibleNavigationController = navigationController
		container._firstLevelNavigationControllers = [navigationController]
		let sceneRender = givenMockSceneOperationManager(window: MockWindow(), container: container)
		return PopSceneOperation(toRoot: toRoot, animated: false, manager: sceneRender)
	}
}
