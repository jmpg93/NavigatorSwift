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
	private enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = MockViewController()
		static let anyOtherView = MockViewController()
	}

	// Class under test
	var sut: SceneOperationManager!

	override func setUp() {
		super.setUp()
		sut = SceneOperationManager(window: MockWindow())
	}
}

// MARK: Tests

extension SceneOperationManagerTests {
	func testGivenEmptyNavigationController_visibleViewController_returnNavigationController() {
		// given
		let nav = UINavigationController()

		// when
		let visibleView = sut.visible(from: nav)

		// then
		XCTAssertEqual(nav, visibleView)
	}

	func testGivenNonEmptyNavigationController_visibleViewController_returnRootViewController() {
		// given
		let view = UIViewController()
		let nav = UINavigationController(rootViewController: view)

		// when
		let visibleView = sut.visible(from: nav)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenEmptyTabBarController_visibleViewController_returnTabBarController() {
		// given
		let tabBar = UITabBarController()

		// when
		let visibleView = sut.visible(from: tabBar)

		// then
		XCTAssertEqual(tabBar, visibleView)
	}

	func testGivenNonEmptyTabBarController_visibleViewController_returnRootViewController() {
		// given
		let view = UIViewController()
		let tabBar = UITabBarController()
		tabBar.setViewControllers([view], animated: false)

		// when
		let visibleView = sut.visible(from: tabBar)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenViewController_visibleViewController_returnViewController() {
		// given
		let view = UIViewController()

		// when
		let visibleView = sut.visible(from: view)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenContainer_visibleViewController_returnRootViewController() {
		// given
		let container = MockViewControllerContainer()
		let view = MockNavigationController()
		container._visibleNavigationController = view

		// when
		let visibleView = sut.visible(from: container)

		// then
		XCTAssertEqual(view, visibleView)
	}
}

// MARK: Helpers general

extension SceneOperationManagerTests {
	func visibleViewController(for manager: SceneOperationManager) -> UIViewController {
		return manager
			.visibleNavigationController!
			.visibleViewController!
	}
}
