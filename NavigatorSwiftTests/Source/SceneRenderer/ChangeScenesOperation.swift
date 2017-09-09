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
	fileprivate enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
	}

	// Class under test
	fileprivate var sut: ChangeScenesOperation!

	override func setUp() {
		super.setUp()
	}
}

extension ChangeScenesOperationTest {
//	func testGivenAnySceneNoRootViewController_changeStackOneScene_installStack() {
//		// given
//		let view = Constants.anyView
//		let mockSceneOne = givenMockScene(name: "A", view: view)
//		givenStubbedWindow()
//		sut = givenSUT(with: [mockSceneOne])
//
//		// when
//		sut.execute(with: nil)
//
//		// then
//		XCTAssertEqual(sut.viewControllerContainer!.visibleNavigationController.visibleViewController!, view)
//		verify(mockWindow).makeKeyAndVisible()
//	}
//
//	func testGivenRootScene_isRootViewController_returnTrue() {
//		//given
//		givenStubbedWindow()
//		let rootScene = givenRootScene()
//
//		// when
//		let isRoot = sut.isRootViewController(matching: rootScene)
//
//		// then
//		XCTAssertTrue(isRoot)
//	}
//
//	func testGivenRootScene_isRootViewControllerWithAnotherScene_returnFalse() {
//		//given
//		givenStubbedWindow()
//		givenRootScene()
//		let anotherScene = givenMockScene(name: Constants.anyOtherScene)
//
//		// when
//		let isRoot = sut.isRootViewController(matching: anotherScene)
//
//		// then
//		XCTAssertFalse(isRoot)
//	}
//
//	func testGivenNoRootScene_isRootViewController_returnFalse() {
//		//given
//		givenStubbedWindow()
//		let scene = givenMockScene()
//
//		// when
//		let isRoot = sut.isRootViewController(matching: scene)
//
//		// then
//		XCTAssertFalse(isRoot)
//	}
}

extension ChangeScenesOperationTest {
//	func givenSUT(with scenes: [Scene]) -> ChangeScenesOperation {
//		let mockSceneRenderer = MockSceneRenderer(window: mockWindow, viewControllerContainer: mockViewControllerContainer)
//		return ChangeScenesOperation(scenes: scenes,
//		                             sceneRendeded: mockSceneRenderer)
//	}
//
//	func givenStubbedWindow() {
//		stub(mockWindow) { stub in
//			when(stub.makeKeyAndVisible()).then(Constants.anyBlock)
//		}
//	}
//
//	func givenMockScene(name: SceneName = Constants.anyScene,
//	                    view: UIViewController = Constants.anyView,
//	                    type: ScenePresentationType = .modal,
//	                    isViewControllerRecyclable: Bool = false) -> MockScene {
//		stub(mockSceneHandler) { stub in
//			when(stub.buildViewController(with: any())).thenReturn(view)
//			when(stub.name.get).thenReturn(name)
//			when(stub.isViewControllerRecyclable.get).thenReturn(isViewControllerRecyclable)
//		}
//
//		return MockScene(sceneHandler: mockSceneHandler,
//		                 parameters: [:],
//		                 type: type,
//		                 animated: false)
//	}
//
//	@discardableResult
//	func givenRootScene() -> Scene {
//		let rootScene = givenMockScene()
//		sut.changeStack(toScenes: [rootScene])
//		return rootScene
//	}
}
