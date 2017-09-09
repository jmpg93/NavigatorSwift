//
//  AddScenesOperationTests.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class AddScenesOperationTests: XCTestCase {
	fileprivate enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
	}

	// Class under test
	fileprivate var sut: AddScenesOperation!

	fileprivate let mockViewController = MockViewController()

	override func setUp() {
		super.setUp()

		sut = AddScenesOperation(scenes: [], rootViewController: mockViewController)
	}
}
