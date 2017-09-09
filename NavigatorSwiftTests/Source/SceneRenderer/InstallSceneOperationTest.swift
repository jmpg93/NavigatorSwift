//
//  InstallSceneOperationTest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class InstallSceneOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: InstallSceneOperation!
}

// MARK: Tests

extension InstallSceneOperationTest {
	func testGivenNoRootScene_installScene_setRootViewController() {
		//given
		givenStubbedSceneHandler()
		givenStubbedViewControllerContainer()
		sut = givenSUT(with: mockScene)
		
		// when
		sut.execute(with: nil)

		// then
		XCTAssertEqual(Constants.anyView, sceneRenderer.visibleNavigationController.visibleViewController)
	}

	func testGivenRootScene_installScene_setRootViewController() {
		//given
		givenStubbedSceneHandler()
		givenStubbedViewControllerContainer()
		givenRootScene()
		let anotherScene = givenMockScene(name: Constants.anyOtherScene, view: Constants.anyOtherView)

		sut = givenSUT(with: anotherScene)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertEqual(Constants.anyOtherView, sceneRenderer.visibleNavigationController.visibleViewController)
	}

	func testGivenNoRootSceneAndViewControllerContainer_installScene_setRootContainer() {
		//given
		let container = UINavigationController()
		givenStubbedSceneHandler(builded: container)
		givenStubbedViewControllerContainer()

		sut = givenSUT(with: mockScene)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertEqual(container, sceneRenderer.viewControllerContainer as! UINavigationController)
	}
}

// MARK: Helpers

extension InstallSceneOperationTest {
	func givenSUT(with scenes: Scene) -> InstallSceneOperation {
		return InstallSceneOperation(scene: scenes, renderer: sceneRenderer)
	}
}

