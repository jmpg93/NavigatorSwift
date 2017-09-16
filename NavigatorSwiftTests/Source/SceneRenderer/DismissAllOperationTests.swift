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
}

// MARK: Tests

extension DismissAllOperationTests {
	func testGivenScenes_dismissAll_dismissRoot() {
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
		verify(mockRootNavigationController).dismiss(animated: any(), completion: any())
	}
}

extension DismissAllOperationTests {
	func givenMockNavigationController() -> MockNavigationController {
		let mockNavigationController = MockNavigationController()

		stub(mockNavigationController) { stub in
			when(stub.dismiss(animated: any(), completion: any())).thenDoNothing()
		}

		return mockNavigationController
	}

	func givenSUT(animated: Bool, root: UINavigationController) -> DismissAllOperation {
		let mockRenderer = givenMockSceneRenderer(window: Window(), root: root)
		return DismissAllOperation(animated: animated,
		                           renderer: mockRenderer)
	}
}
