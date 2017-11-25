//
//  InstallSceneOperationTest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class InstallSceneOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: InstallSceneOperation!
}

// MARK: Tests

extension InstallSceneOperationTest {
	func testGivenScene_installScene_setRootViewController() {
		//given
		let view = UIViewController()
		let scene = givenMockScene(name: Constants.anyScene, view: view, type: .push)
		let window = MockWindow()
		sut = givenSUT(scene: scene, window: window)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertNotNil(view.navigationController)
		XCTAssertEqual(window.rootViewController, view.navigationController)
		XCTAssertTrue(window.madeKeyAndVisible)
	}

	func testGivenContainerScene_installScene_setRootViewController() {
		//given
		let container = MockViewControllerContainer()
		let scene = givenMockScene(name: Constants.anyScene, view: container, type: .push)
		let window = MockWindow()
		sut = givenSUT(scene: scene, window: window)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertNil(container.navigationController)
		XCTAssertEqual(window.rootViewController, container.rootViewController)
		XCTAssertTrue(window.madeKeyAndVisible)
	}
}

extension InstallSceneOperationTest {
	func givenNavigationController() -> MockNavigationController {
		let view = MockViewController()
		return MockNavigationController(viewControllers: [view])
	}

	func givenSUT(scene: Scene, window: UIWindow) -> InstallSceneOperation {
		let rootNavigation = givenNavigationController()
		let mockSceneRenderer = givenMockSceneRenderer(window: window, root: rootNavigation)
		return InstallSceneOperation(scene: scene, renderer: mockSceneRenderer)
	}
}

