//
// NavigatorSwiftTests.swift
// NavigatorSwiftTests
//
// Created by jmpuerta on 3/9/17.
// Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest


class SceneOperationManagerTests: SceneOperationTests {
	fileprivate enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
	}

	// Class under test
	var sut: SceneOperationManager!

	override func setUp() {
		super.setUp()
		let window = MockWindow()
		let view = UINavigationController()
		let mockViewControllerContainer = givenMockViewControllerContainer(root: view)
		sut = SceneOperationManager(window: window, viewControllerContainer: mockViewControllerContainer)
	}
}

// MARK: Tests

extension SceneOperationManagerTests {
	func testGivenEmptyNavigationController_visibleViewController_returnNavigationController() {
		// given
		let nav = UINavigationController()

		// when
		let visibleView = sut.visibleViewController(from: nav)

		// then
		XCTAssertEqual(nav, visibleView)
	}

	func testGivenNonEmptyNavigationController_visibleViewController_returnRootViewController() {
		// given
		let view = UIViewController()
		let nav = UINavigationController(rootViewController: view)

		// when
		let visibleView = sut.visibleViewController(from: nav)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenEmptyTabBarController_visibleViewController_returnTabBarController() {
		// given
		let tabBar = UITabBarController()

		// when
		let visibleView = sut.visibleViewController(from: tabBar)

		// then
		XCTAssertEqual(tabBar, visibleView)
	}

	func testGivenNonEmptyTabBarController_visibleViewController_returnRootViewController() {
		// given
		let view = UIViewController()
		let tabBar = UITabBarController()
		tabBar.setViewControllers([view], animated: false)

		// when
		let visibleView = sut.visibleViewController(from: tabBar)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenViewController_visibleViewController_returnViewController() {
		// given
		let view = UIViewController()

		// when
		let visibleView = sut.visibleViewController(from: view)

		// then
		XCTAssertEqual(view, visibleView)
	}
}

// MARK: Helpers general

extension SceneOperationManagerTests {
	func visibleViewController(for renderer: SceneOperationManager) -> UIViewController {
		return renderer
			.viewControllerContainer
			.visibleNavigationController
			.visibleViewController!
	}
}
