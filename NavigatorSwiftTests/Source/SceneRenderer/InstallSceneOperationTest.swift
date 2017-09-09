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
		givenStubbedWindow()
		givenStubbedSceneHandler()
		givenStubbedViewControllerContainer()
		
		sut = givenSUT(with: mockScene)
		
		// when
		sut.execute(with: nil)

		// then
		XCTAssertEqual(Constants.anyView, sceneRenderer.rootViewController)
	}

	func testGivenRootScene_installScene_setRootViewController() {
//		//given
//		givenStubbedWindow()
//		givenRootScene()
//		let anotherScene = givenMockScene(name: Constants.anyOtherScene, view: Constants.anyOtherView)
//
//		// when
//		sut.installScene(asRootViewController: anotherScene)
//		let rootViewController = visibleViewController(for: sut)
//
//		// then
//		XCTAssertEqual(Constants.anyOtherView, rootViewController)
	}
}

// MARK: Helpers

extension InstallSceneOperationTest {
	func givenSUT(with scenes: Scene) -> InstallSceneOperation {
		return InstallSceneOperation(scene: scenes, renderer: sceneRenderer)
	}
}

