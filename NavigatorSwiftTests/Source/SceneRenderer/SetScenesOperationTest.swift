//
//  SetScenesOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class SetScenesOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: SetScenesOperation!
}

extension SetScenesOperationTest {
	func testGivenNoScenes_changeStackOneScene_DoNothing() {
		// given
		sut = givenSUT(with: [], root: UIViewController(), window: Window())

		// when
		sut.execute(with: nil)

		// then
		verifyNoMoreInteractions(mockDismissAllOperation)
		verifyNoMoreInteractions(mockRecycleOperation)
		verifyNoMoreInteractions(mockInstallOperation)
	}

	func testGivenAnySceneNoRootViewController_changeStackOneScene_installStack() {
		// given
		let mockScenes = givenMockScenes()
		let	window = Window()
		let view = UIViewController()
		sut = givenSUT(with: mockScenes, root: view, window: window)

		// when
		sut.execute(with: nil)

		// then
		verify(mockDismissAllOperation).execute(with: any())
		verify(mockInstallOperation).execute(with: any())
		verify(mockRecycleOperation).execute(with: any())
	}


	func testGivenAnySceneRootViewController_changeStackOneScene_installStack() {
		// given
		let root = UIViewController()
		let view = UIViewController()
		let scene = Constants.anyScene
		let mockScene = givenMockScene(name: scene, view: view, type: .modal)
		sut = givenSUT(with: [mockScene], root: root, scene: scene, window: Window())

		// when
		sut.execute(with: nil)

		// then
		verify(mockDismissAllOperation).execute(with: any())
		verify(mockRecycleOperation).execute(with: any())
		verifyNoMoreInteractions(mockInstallOperation)
	}


	func testGivenRootScene_isRootViewController_returnTrue() {
		// given
		let root = UIViewController()
		let view = UIViewController()
		let rootScene = Constants.anyScene
		let mockScene = givenMockScene(name: rootScene, view: view, type: .modal)
		sut = givenSUT(with: [mockScene], root: root, scene: rootScene, window: Window())
		
		// when
		let isRoot = sut.isRootViewController(matching: mockScene)

		// then
		XCTAssertTrue(isRoot)
	}


	func testGivenRootScene_isRootViewControllerWithAnotherScene_returnFalse() {
		// given
		let root = UIViewController()
		let view = UIViewController()
		let rootScene = Constants.anyScene
		let noRootScene = Constants.anyOtherScene
		let mockScene = givenMockScene(name: noRootScene, view: view, type: .modal)

		sut = givenSUT(with: [mockScene], root: root, scene: rootScene, window: Window())

		// when
		let isRoot = sut.isRootViewController(matching: mockScene)

		// then
		XCTAssertFalse(isRoot)
	}

	func testGivenNoRootScene_isRootViewController_returnFalse() {
		//given
		let scene = Constants.anyScene
		let view = Constants.anyView
		let mockScene = givenMockScene(name: scene, view: view, type: .modal)

		sut = givenSUT(with: [], root: view, scene: SceneName("NoRoot"), window: Window())

		// when
		let isRoot = sut.isRootViewController(matching: mockScene)

		// then
		XCTAssertFalse(isRoot)
	}
}

extension SetScenesOperationTest {
	func givenSUT(with scenes: [Scene],
	              root: UIViewController,
	              scene: SceneName? = nil,
	              window: UIWindow) -> SetScenesOperation {
		let nav = UINavigationController(rootViewController: root)
		let mockRenderer = givenMockSceneRenderer(window: window, root: nav, scene: scene)
		return SetScenesOperation(scenes: scenes, renderer: mockRenderer)
	}
}

