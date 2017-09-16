//
//  InstallSceneOperationTest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class InstallSceneOperationTest: SceneOperationTests {
	// Class under test
	fileprivate var sut: InstallSceneOperation!
}

// MARK: Tests

extension InstallSceneOperationTest {
	func testGivenNoRootScene_installScene_setRootViewController() {
		//given
		let view = UIViewController()
		let name = Constants.anyScene
		let window = Window()
		let mockRenderer = givenMockSceneRenderer(window: window, root: view)
		let mockScene = givenMockScene(name: name, view: view, type: .push)
		// when
		sut = InstallSceneOperation(scene: mockScene, renderer: mockRenderer)
		sut.execute(with: nil)

		// then
		XCTAssertEqual(mockRenderer.visibleNavigationController, view.navigationController!)
		XCTAssertTrue(window.didCallMakeKeyAndVisible)
		XCTAssertNotNil(window.rootViewController)
	}
}

