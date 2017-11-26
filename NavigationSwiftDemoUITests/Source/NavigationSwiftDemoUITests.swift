//
//  NavigationSwiftDemoUITests.swift
//  NavigationSwiftDemoUITests
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import XCTest

class NavigationSwiftDemoUITests: XCTestCase {
	fileprivate enum Constants {
		static let uiTesting = "UITests"

		static let root = "root"
		static let modal = "modal"
		static let push = "push"
		static let modalNav = "modalNav"
		static let modalDismissFirst = "modal dismissFirst"
		static let modalDismissScene = "modal dismissScene"
		static let modalModalDismissAll = "modal dismissAll"
		static let popover = "popover"
		static let transition = "popover"
		static let preview = "preview"
		static let pushPop = "push pop"
		static let pushPushPopToRoot = "push popToRoot"
		static let set2Scenes = "set 2 scenes"
		static let dismissAll = "dismissAll"
		static let popToRoot = "popToRoot"
	}

	fileprivate enum TestsCases {
		static let base = [Constants.modal, Constants.push, Constants.modalNav]
		static let dismiss = [Constants.modalDismissFirst, Constants.modalDismissScene, Constants.modalModalDismissAll]
		static let pop = [Constants.pushPop, Constants.pushPushPopToRoot]
		static let custom = [Constants.transition, Constants.popover, Constants.set2Scenes]
	}

	var app: XCUIApplication!
	
	override func setUp() {
		super.setUp()
		
		continueAfterFailure = true
		app = XCUIApplication()
		app.launchArguments = [Constants.uiTesting]
		app.launch()
	}

	func test_base() {
		//given
		let states = TestsCases.base

		for state in states {
			//when
			tapCell(state)

			//then
			assertState(state)
			backToRoot()
		}
    }

	func test_dismiss() {
		//given
		let states = TestsCases.dismiss

		for state in states {
			//when
			tapCell(state)

			//then
			assertState(Constants.root)
			backToRoot()
		}
	}

	func test_pop() {
		//given
		let states = TestsCases.pop

		for state in states {
			//when
			tapCell(state)

			//then
			assertState(Constants.root)
			backToRoot()
		}
	}

	func test_custom() {
		//given
		let states = TestsCases.custom

		for state in states {
			//when
			tapCell(state)

			//then
			assertState(state)
			backToRoot()
		}
	}
}

extension NavigationSwiftDemoUITests {
	func tapCell(_ cell: String) {
		XCUIApplication().collectionViews.staticTexts[cell].tap()
	}

	func assertState(_ state: String) {
		wait(state)
		XCTAssertEqual(app.stateLabel.label, state)
	}

	func wait(_ state: String) {
		_ = app.stateLabel.staticTexts[state].waitForExistence(timeout: 0.3)
	}

	func backToRoot() {
		tapCell(Constants.dismissAll)
		wait(Constants.dismissAll)
		tapCell(Constants.popToRoot)
		wait(Constants.popToRoot)
	}
}
