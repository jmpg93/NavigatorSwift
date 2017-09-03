//
//  NavigatorSwiftTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import NavigatorSwift
import XCTest
import Cuckoo

class NavigatorSwiftTests: XCTestCase {
	var sut: SceneRenderer!

	let mockWindow = MockWindow()
	let mockScene = MockScene(sceneHandler: MockSceneHandler(),
	                          parameters: [:],
	                          type: .modal,
	                          animated: false)

    override func setUp() {
        super.setUp()

		sut = SceneRenderer(window: mockWindow)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
		sut.changeStack(toScenes: [mockScene])

		verify(mockWindow).makeKeyAndVisible()
    }
}
