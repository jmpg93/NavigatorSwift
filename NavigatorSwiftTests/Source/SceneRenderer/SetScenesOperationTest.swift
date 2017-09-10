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

	lazy var mockInstallOperation: MockSceneOperation = self.givenMockOperation()
	lazy var mockDismissOperation: MockSceneOperation = self.givenMockOperation()
	lazy var mockRecycleOperation: MockSceneOperation = self.givenMockOperation()
}

extension SetScenesOperationTest {
	func testGivenNoScenes_changeStackOneScene_DoNothing() {
		// given
		sut = givenSUT()

		// when
		sut.execute(with: nil)

		// then
		verifyNoMoreInteractions(mockDismissOperation)
		verifyNoMoreInteractions(mockRecycleOperation)
		verifyNoMoreInteractions(mockInstallOperation)
	}

	func testGivenAnySceneNoRootViewController_changeStackOneScene_installStack() {
		// given
		sut = givenSUT(with: [mockScene])

		// when
		sut.execute(with: nil)

		// then
		verify(mockDismissOperation).execute(with: any())
		verify(mockInstallOperation).execute(with: any())
		verify(mockRecycleOperation).execute(with: any())
	}

	func testGivenAnySceneRootViewController_changeStackOneScene_installStack() {
		// given
		let root = UINavigationController(rootViewController: Constants.anyView)
		let scene = givenMockScene(view: root)
		sut = givenSUT(with: [scene], rootViewController: root)

		// when
		sut.execute(with: nil)

		// then
		verify(mockDismissOperation).execute(with: any())
		verify(mockRecycleOperation).execute(with: any())
		verifyNoMoreInteractions(mockInstallOperation)
	}

	func testGivenRootScene_isRootViewController_returnTrue() {
		//given
		let rootScene = givenRootScene()
		sut = givenSUT()
		
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

extension SetScenesOperationTest {
	func givenMockOperation() -> MockSceneOperation {
		let mockOperation = MockSceneOperation()

		stub(mockOperation) { stub in
			when(stub.execute(with: any())).then { completion in
				completion?()
			}
			when(stub.then(any())).then { op in
				return OrderedSceneOperation(first: mockOperation, last: op)
			}
		}
		
		return mockOperation
	}

	func givenSUT(with scenes: [Scene] = [], rootViewController: UIViewController? = nil) -> SetScenesOperation {
		let root = rootViewController ?? Constants.anyView

		let container = givenStubbedViewControllerContainer(root: root)
		let sceneRenderer = MockSceneRenderer(window: UIWindow(), viewControllerContainer: container)

		stub(sceneRenderer) { stub in
			when(stub.rootViewController.get).thenReturn(root)
			when(stub.dismissAll(animated: any())).thenReturn(mockDismissOperation)
			when(stub.install(scene: any())).thenReturn(mockInstallOperation)
			when(stub.recycle(scenes: any())).thenReturn(mockRecycleOperation)
		}
		
		return SetScenesOperation(scenes: scenes, renderer: sceneRenderer)
	}
}
