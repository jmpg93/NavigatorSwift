//
//  ChangeScenesOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class ChangeScenesOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: ChangeScenesOperation!
}

extension ChangeScenesOperationTest {
	func testGivenAnySceneNoRootViewController_changeStackOneScene_installStack() {
		// given

		sut = givenSUT(with: [mockScene])

		// when
		sut.execute(with: nil)

		// then
		XCTAssertEqual(sceneRenderer.visibleNavigationController.visibleViewController,
		               mockScene.sceneHandler.buildViewController(with: [:]))
	}

	func testGivenRootScene_isRootViewController_returnTrue() {
		//given
		let rootScene = givenRootScene()
		sut = givenSUT(with: [rootScene])
		
		// when
		let isRoot = sut.isRootViewController(matching: rootScene)

		// then
		XCTAssertTrue(isRoot)
	}

	func testGivenRootScene_isRootViewControllerWithAnotherScene_returnFalse() {
		//given
		givenRootScene()
		let anotherScene = givenMockScene(name: Constants.anyOtherScene, view: Constants.anyOtherView)

		sut = givenSUT(with: [anotherScene])

		// when
		let isRoot = sut.isRootViewController(matching: anotherScene)

		// then
		XCTAssertFalse(isRoot)
	}

	func testGivenNoRootScene_isRootViewController_returnFalse() {
		//given
		let scene = givenMockScene()

		sut = givenSUT(with: [scene])

		// when
		let isRoot = sut.isRootViewController(matching: scene)

		// then
		XCTAssertFalse(isRoot)
	}
}

extension ChangeScenesOperationTest {
	func givenSUT(with scenes: [Scene]) -> ChangeScenesOperation {
		givenStubbedViewControllerContainer()
		return ChangeScenesOperation(scenes: scenes, sceneRendeded: sceneRenderer)
	}
}
