//
//  NavigationRequestComponentTests.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class NavigationRequestComponentTests: XCTestCase {
	fileprivate enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyPresentMode: ScenePresentationType = .modal
		static let anyParameters: Parameters = [:]
		static let anyAnimated = false
	}

	// Class under test
	var sut: NavigationRequestComponent!

	override func setUp() {
		super.setUp()

		sut = NavigationRequestComponent(name: Constants.anyScene,
		                                 presentMode: Constants.anyPresentMode,
		                                 parameters: Constants.anyParameters,
		                                 animated: Constants.anyAnimated)
	}
}

// MARK: Tests

extension NavigationRequestComponentTests {
	func testGivenModalNonAnimatedPath_pathComponent_isBuildRight() {
		//given
		let path = "anyScene{presentAs=modal;animated=false}"
		let sut = request(name: Constants.anyScene,
		                  mode: .modal,
		                  animated: false)
		// when
		let pathComponent = sut.pathComponent

		//then
		XCTAssertEqual(pathComponent, path)
	}

	func testGivenPushAnimatedPath_pathComponent_isBuildRight() {
		//given
		let path = "anyScene{presentAs=push;animated=true}"
		let sut = request(name: Constants.anyScene,
		                  mode: .push,
		                  animated: true)
		// when
		let pathComponent = sut.pathComponent

		//then
		XCTAssertEqual(pathComponent, path)
	}

	func testGivenModalInsideNavigationAnimatedPath_pathComponent_isBuildRight() {
		//given
		let path = "anyScene{presentAs=modalInNav;animated=true}"
		let sut = request(name: Constants.anyScene,
		                  mode: .modalNavigation,
		                  animated: true)
		// when
		let pathComponent = sut.pathComponent

		//then
		XCTAssertEqual(pathComponent, path)
	}
}

// MARK: Helpers

extension NavigationRequestComponentTests {
	func request(name: SceneName,
	             mode: ScenePresentationType,
	             animated: Bool) -> NavigationRequestComponent {
		return NavigationRequestComponent(name: name,
		                                  presentMode: mode,
		                                  parameters: [:],
		                                  animated: animated)
	}
}
