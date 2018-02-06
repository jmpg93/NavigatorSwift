//
//  OrderedSceneOperationTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 23/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest

class OrderedSceneOperationTests: SceneOperationTests {
	// Class under test
	fileprivate var sut: OrderedSceneOperation!
}

extension OrderedSceneOperationTests {
	func test_execute_executeOperations() {
		// given
		let op1 = givenMockOperation()
		let op2 = givenMockOperation()
		sut = OrderedSceneOperation(first: op1, last: op2)

		// when
		sut.execute(with: nil)

		// then
		XCTAssertTrue(op1.executed)
		XCTAssertTrue(op2.executed)
	}
}
