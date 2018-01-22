//
//  NavigatorSwiftDemoUITests.swift
//  NavigatorSwiftDemoUITests
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import XCTest

class NavigatorSwiftDemoUITests: XCTestCase {
	fileprivate enum Constants {
		static let uiTesting = "UITests"

		static let root = "root"
		static let modal = "modal"
		static let modalModal = "modal modal"
		static let push = "push"
		static let pushPush = "push push"
		static let modalNav = "modalNav"
		static let modalDismissFirst = "modal dismissFirst"
		static let modalDismissScene = "modal dismissScene"
		static let modalModalDismissAll = "modal dismissAll"
		static let popover = "popover"
		static let transition = "transition"
		static let preview = "preview"
		static let pushPop = "push pop"
		static let pushPushPopToRoot = "push popToRoot"
		static let set2Scenes = "set 2 scenes"
		static let dismissAll = "dismissAll"
		static let popToRoot = "popToRoot"
		static let rootModal = "root modal"
		static let rootModalNav = "root modalNav"
		static let rootModalNavPush = "root modalNav push"
	}

	fileprivate enum TestsCases {
		static let base = [Constants.modal, Constants.push, Constants.modalNav]
		static let dismiss = [Constants.modalDismissFirst, Constants.modalDismissScene, Constants.modalModalDismissAll]
		static let pop = [Constants.pushPop, Constants.pushPushPopToRoot]
		static let custom = [Constants.transition Constants.popover, Constants.set2Scenes]
		static let recycle = [Constants.rootModal, Constants.rootModalNav, Constants.rootModalNavPush]
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

	func test_recycle() {
		//given
		let states = TestsCases.recycle

		for state in states {
			//when
			tapCell(state)

			//then
			let recycledState = stateForRecycle(state: state)
			assertState(recycledState)
			backToRoot()
		}
	}

	func testGivenModal_recycle() {
		//given
		tapCell(Constants.modal)

		//then
		test_recycle()
	}

	func testGivenModalModal_recycle() {
		//given
		tapCell(Constants.modalModal)

		//then
		test_recycle()
	}

	func testGivenPush_recycle() {
		//given
		tapCell(Constants.push)

		//then
		test_recycle()
	}

	func testGivenPushPush_recycle() {
		//given
		tapCell(Constants.pushPush)

		//then
		test_recycle()
	}

	func testGivenModalNav_recycle() {
		//given
		tapCell(Constants.modalNav)

		//then
		test_recycle()
	}
}

extension NavigatorSwiftDemoUITests {
	func tapCell(_ cell: String) {
		XCUIApplication().collectionViews.staticTexts[cell].tap()
	}

	func assertState(_ state: String) {
		wait(state)
		XCTAssertEqual(app.stateLabel.firstMatch.label, state)
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

	func stateForRecycle(state: String) -> String {
		return state.components(separatedBy: .whitespaces).last ?? state
	}
}
