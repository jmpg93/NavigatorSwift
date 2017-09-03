//
//  NavigatorSwiftTests.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class SceneRendererTests: XCTestCase {
	fileprivate enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
	}

	// Class under test
	var sut: SceneRenderer!

	// Dependencies
	let mockWindow = MockWindow()

	// Componenets
	let mockSceneHandler =  MockSceneHandler()

	override func setUp() {
		super.setUp()

		sut = SceneRenderer(window: mockWindow)
	}
}

// MARK: Tests 

extension SceneRendererTests {
	func testGivenAnySceneNoRootViewController_changeStack_windowMakeKeyAndVisible() {
		// given
		let mockScene = givenMockScene()
		givenStubbedWindow()

		// when
		sut.changeStack(toScenes: [mockScene])

		XCTAssertNotNil(sut.viewControllerContainer)
		verify(mockWindow).makeKeyAndVisible()
	}
}

// MARK: Helpers 

extension SceneRendererTests {
	func givenStubbedWindow() {
		stub(mockWindow) { stub in
			when(stub.makeKeyAndVisible()).then(Constants.anyBlock)
		}
	}

	func givenMockScene() -> MockScene {
		stub(mockSceneHandler) { stub in
			when(stub.buildViewController(with: any())).thenReturn(Constants.anyView)
			when(stub.name.get).thenReturn(Constants.anyScene)
		}

		return MockScene(sceneHandler: mockSceneHandler,
		                 parameters: [:],
		                 type: .modal,
		                 animated: false)
	}
}
