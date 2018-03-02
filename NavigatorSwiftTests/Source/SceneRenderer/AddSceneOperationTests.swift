//
//  AddSceneOperationTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 23/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class AddSceneOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: AddSceneOperation!
}

// MARK: Tests

extension AddSceneOperationTests {
	func testGivenModalScene_execute_presentScene() {
		//given
		let viewController = MockViewController()
		let scene = modalScene
		sut = givenSUT(scenes: [scene], root: viewController)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(viewController.didPresentViewController)
		XCTAssertNil(scene._view.navigationController)
	}

	func testGivenPushScene_execute_pushScene() {
		//given
		let root = MockViewController()
		sut = givenSUT(scenes: [pushScene], root: root)

		// when
		sut.execute(with: nil)

		// then
		let navigationController = root.navigationController as! MockNavigationController
		XCTAssertTrue(navigationController.pushed)
	}

	func testGivenModalNavigationSceneScene_execute_presentWithNavigationScene() {
		//given
		let root = MockViewController()
		sut = givenSUT(scenes: [modalNavigationScene], root: root)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(root.didPresentViewController)
	}
}

// MARK: Helpers

extension AddSceneOperationTests {
	var modalScene: MockScene {
		return givenMockScene(name: "modal", view: MockViewController(), type: .modal)
	}

	var pushScene: MockScene {
		return givenMockScene(name: "push", view: MockViewController(), type: .push)
	}

	var modalNavigationScene: MockScene {
		return givenMockScene(name: "modalNavigation", view: MockViewController(), type: .modalNavigation)
	}

	func givenSUT(scenes: [Scene], root: MockViewController) -> AddSceneOperation {
		let mockSceneOperationManager = givenMockSceneOperationManager(window: MockWindow(), root: root)
		return AddSceneOperation(scenes: scenes, manager: mockSceneOperationManager)
	}
}

