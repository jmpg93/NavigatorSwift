//
//  NavigatorSwiftTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import NavigatorSwift
import XCTest


class NavigatorSwiftTests: XCTestCase {
	var sut: SceneRenderer!

	let windowMock = UIWindow()

    override func setUp() {
        super.setUp()
		sut = SceneRenderer(window: windowMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
		
    }
}
