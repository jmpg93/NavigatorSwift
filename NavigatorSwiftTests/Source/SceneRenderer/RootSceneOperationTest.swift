//
//  InstallSceneOperationTest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class RootSceneOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: RootSceneOperation!
}

// MARK: Tests

extension RootSceneOperationTest {
	func testGivenScene_installScene_setRootViewController() {
		//given
		let view = MockViewControllerContainer()
		view._canBeReuse = false
		let scene = givenMockScene(name: Constants.anyScene, view: view, type: .root)
		let window = MockWindow()
		sut = givenSUT(scene: scene, window: window)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertEqual(window.rootViewController, view.rootViewController)
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

extension RootSceneOperationTest {
	func givenSUT(scene: Scene, window: UIWindow) -> RootSceneOperation {
		let mockSceneOperationManager = givenMockSceneOperationManager(window: window, root: MockViewController())
		return RootSceneOperation(scene: scene, manager: mockSceneOperationManager)
	}
}

