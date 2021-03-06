//
//  RecycleSceneOperationTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class RecycleSceneOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: RecycleSceneOperation!

	override func setUp() {
		super.setUp()

		let mockSceneOperationManager = MockSceneOperationManager(window: MockWindow())
		sut = RecycleSceneOperation(scenes: [], manager: mockSceneOperationManager)
	}
}

extension RecycleSceneOperationTests {
	func testGivenSceneWithModalPresentation_isViewControllerPresentedAsRequired_returnTrue() {
		// given
		let modal = MockViewController()
		modal.overridePresentingViewController = true
		modal._presentingViewController = MockViewController()
		
		// when
		let isPresentedAsRequire = modal.isPresentedAsRequire(for: .modal)

		// then
		XCTAssertTrue(isPresentedAsRequire)
	}

	func testGivenSceneWithNonModalPresentation_isViewControllerPresentedAsRequired_returnFalse() {
		// given
		let modal = MockViewController()

		// when
		let isPresentedAsRequire = modal.isPresentedAsRequire(for: .modal)

		// then
		XCTAssertFalse(isPresentedAsRequire)
	}

	func testGivenSceneWithPushPresentation_isViewControllerPresentedAsRequired_returnTrue() {
		// given
		let pushed = MockViewController()
		pushed.overrideNavigationController = true
		pushed._navigationController = MockNavigationController()

		// when
		let isPresentedAsRequire = pushed.isPresentedAsRequire(for: .push)

		// then
		XCTAssertTrue(isPresentedAsRequire)
	}

	func testGivenSceneWithNonPushPresentation_isViewControllerPresentedAsRequired_returnFalse() {
		// given
		let nonPushed = MockViewController()

		// when
		let isPresentedAsRequire = nonPushed.isPresentedAsRequire(for: .push)

		// then
		XCTAssertFalse(isPresentedAsRequire)
	}

	func testGivenSceneWithModalNavigationPresentation_isViewControllerPresentedAsRequired_returnTrue() {
		// given
		let modalNavigation = MockViewController()
		let navigationController =  MockNavigationController(viewControllers: [modalNavigation])
		navigationController.overridePresentingViewController = true
		navigationController._presentingViewController = MockViewController()
		modalNavigation.overrideNavigationController = true
		modalNavigation._navigationController = navigationController

		// when
		let isPresentedAsRequire = modalNavigation.isPresentedAsRequire(for: .modalNavigation)

		// then
		XCTAssertTrue(isPresentedAsRequire)
	}

	func testGivenSceneWithNonModalNavigationPresentation_isViewControllerPresentedAsRequired_returnFalse() {
		// given
		let nonModalNavigation = MockViewController()

		// when
		let isPresentedAsRequire = nonModalNavigation.isPresentedAsRequire(for: .modalNavigation)

		// then
		XCTAssertFalse(isPresentedAsRequire)
	}
}


// MARK: Helpers general

extension RecycleSceneOperationTests {
	func givenMockScene(type: ScenePresentationType, recyclable: Bool) -> MockScene {
		let sceneHandler = MockSceneHandler()
		sceneHandler._view = MockViewController()
		sceneHandler._isReloadable = recyclable
		return MockScene(sceneHandler: sceneHandler, type: type)
	}

	func givenViewController(for scene: Scene) -> UIViewController {
		let nav = givenNavigationController(with: scene.sceneHandler.name)
		let vc = scene.view()

		switch scene.type {
		case .modal:
			nav.present(vc, animated: false, completion: nil)
		case .push:
			nav.pushViewController(vc, animated: false)
		case .modalNavigation:
			nav.present(UINavigationController(rootViewController: vc), animated: false, completion: nil)
		case .select, .root:
			break
		}

		return vc
	}

	func givenViewController(with sceneName: SceneName) -> UIViewController {
		let vc = MockViewController()
		vc.sceneName = sceneName.value
		return vc
	}

	func givenNavigationController(with sceneName: SceneName, count: Int = 1) -> UINavigationController {
		let nav = MockNavigationController()

		for _ in 0..<count {
			nav.viewControllers.append(givenViewController(with: sceneName))
		}

		return nav
	}

	func givenTabBarController(with sceneName: SceneName, count: Int = 1) -> UITabBarController {
		let tab = UITabBarController()
		tab.viewControllers = []

		for _ in 0..<count {
			tab.viewControllers?.append(givenViewController(with: sceneName))
		}

		return tab
	}
}
