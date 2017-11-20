//
//  SetScenesOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest


class SetScenesOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: SetScenesOperation!

	fileprivate var mockDismissAllOperation: MockSceneOperation!
	fileprivate var mockInstallOperation: MockSceneOperation!
	fileprivate var mockRecycleOperation: MockSceneOperation!

	override func setUp() {
		super.setUp()

		mockDismissAllOperation = givenMockOperation()
		mockInstallOperation = givenMockOperation()
		mockRecycleOperation = givenMockOperation()
	}
}

extension SetScenesOperationTest {
	func testGivenNoScenes_execute_DoNothing() {
		// given
		sut = givenSUT(with: [], root: MockViewController())

		// when
		sut.execute(with: nil)

		// then
		XCTAssertFalse(mockDismissAllOperation.executed)
		XCTAssertFalse(mockRecycleOperation.executed)
		XCTAssertFalse(mockInstallOperation.executed)
	}

	func testGivenAnySceneNoRootViewController_execute_installStack() {
		// given
		sut = givenSUT(with: givenMockScenes(), root: MockViewController())

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(mockDismissAllOperation.executed)
		XCTAssertTrue(mockRecycleOperation.executed)
		XCTAssertTrue(mockInstallOperation.executed)
	}

	func testGivenAnySceneRootViewController_execute_installStack() {
		// given
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .modal)
		sut = givenSUT(with: [mockScene], root: MockViewController(), scene: Constants.anyScene)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(mockDismissAllOperation.executed)
		XCTAssertTrue(mockRecycleOperation.executed)
		XCTAssertFalse(mockInstallOperation.executed)
	}

	func testGivenRootScene_isRootViewController_returnTrue() {
		// given
		let mockScene = givenMockScene(name: Constants.anyScene, view: MockViewController(), type: .modal)
		sut = givenSUT(with: [mockScene], root: MockViewController(), scene: Constants.anyScene)
		
		// when
		let isRoot = sut.isRootViewController(matching: mockScene)

		// then
		XCTAssertTrue(isRoot)
	}


	func testGivenRootScene_isRootViewControllerWithAnotherScene_returnFalse() {
		// given
		let mockScene = givenMockScene(name: Constants.anyOtherScene, view: MockViewController(), type: .modal)
		sut = givenSUT(with: [mockScene], root: MockViewController(), scene: Constants.anyScene)

		// when
		let isRoot = sut.isRootViewController(matching: mockScene)

		// then
		XCTAssertFalse(isRoot)
	}

	func testGivenNoRootScene_isRootViewController_returnFalse() {
		//given
		let mockScene = givenMockScene(name: Constants.anyScene, view: Constants.anyView, type: .modal)
		sut = givenSUT(with: [], root: Constants.anyView, scene: Constants.anyOtherScene)

		// when
		let isRoot = sut.isRootViewController(matching: mockScene)

		// then
		XCTAssertFalse(isRoot)
	}
}

extension SetScenesOperationTest {
	func givenSUT(with scenes: [Scene],
	              root: UIViewController,
	              scene: SceneName? = nil ) -> SetScenesOperation {
		let nav = UINavigationController(rootViewController: root)
		let mockRenderer = givenMockSceneRenderer(window: MockWindow(), root: nav, scene: scene)
		mockRenderer._dismissAllOperation = mockDismissAllOperation
		mockRenderer._recycleScenes = mockRecycleOperation
		mockRenderer._installOperation = mockInstallOperation
		return SetScenesOperation(scenes: scenes, renderer: mockRenderer)
	}
}

