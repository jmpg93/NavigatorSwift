//
//  DismissAllOperationTests.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 16/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest


class DismissAllOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: DismissAllOperation!
}

// MARK: Tests

extension DismissAllOperationTests {
	func testGivenScenes_dismissAllAnimated_dismissRoot() {
		// given
		let mockRootNavigationController = givenMockNavigationController()
		sut = givenSUT(animated: true, root: mockRootNavigationController)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(mockRootNavigationController.dismissed)
	}

	func testGivenScenes_dismissAllNonAnimated_dismissRoot() {
		// given
		let mockRootNavigationController = givenMockNavigationController()
		sut = givenSUT(animated: false, root: mockRootNavigationController)
		var didExecute = false

		// when 
		sut.execute {
			didExecute = true
		}

		// then
		XCTAssertTrue(didExecute)
		XCTAssertTrue(mockRootNavigationController.dismissed)
	}
}

extension DismissAllOperationTests {
	func givenMockNavigationController() -> MockNavigationController {
		return MockNavigationController()
	}

	func givenSUT(animated: Bool, root: UINavigationController) -> DismissAllOperation {
		let mockRenderer = givenMockSceneOperationManager(window: MockWindow(), root: root)
		return DismissAllOperation(animated: animated,
		                           manager: mockRenderer)
	}
}
