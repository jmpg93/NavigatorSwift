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
	func test_dismissAllAnimated_dismissRoot() {
		// given
		let root = MockViewController()
		sut = givenSUT(animated: true, root: root)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(root.dismissed)
	}

	func test_dismissAllNonAnimated_dismissRoot() {
		// given
		let root = MockViewController()
		sut = givenSUT(animated: false, root: root)
		var didExecute = false

		// when 
		sut.execute {
			didExecute = true
		}

		// then
		XCTAssertTrue(didExecute)
		XCTAssertTrue(root.dismissed)
	}
}

extension DismissAllOperationTests {
	func givenSUT(animated: Bool, root: MockViewController) -> DismissAllOperation {
		let manager = givenMockSceneOperationManager(window: MockWindow(), root: root)
		return DismissAllOperation(animated: animated,
		                           manager: manager)
	}
}
