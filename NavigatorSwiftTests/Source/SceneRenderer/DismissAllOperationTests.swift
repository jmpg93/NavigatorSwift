//
//  DismissAllOperationTests.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 16/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class DismissAllOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: DismissAllOperation!

	// Dependencies
	let mockViewController = UIViewController()
}

// MARK: Tests

extension DismissAllOperationTests {
	func testGivenScenes_dismissAll_executeCompletion() {
		// given
		sut = givenSUT(animated: false)
		var didExecute = false

		// when 
		sut.execute {
			didExecute = true
		}

		XCTAssertTrue(didExecute)
		XCTAssertTrue(mockViewController.navigationController!.viewControllers.count == 1)
	}
}

extension DismissAllOperationTests {
	func givenSUT(animated: Bool) -> DismissAllOperation {
		let mockRenderer = givenMockSceneRenderer(window: Window(),
		                                          root: mockViewController)
		return DismissAllOperation(animated: animated,
		                           renderer: mockRenderer)
	}
}
