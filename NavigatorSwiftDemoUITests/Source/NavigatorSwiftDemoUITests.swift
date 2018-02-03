//
//  NavigatorSwiftDemoUITests.swift
//  NavigatorSwiftDemoUITests
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import XCTest

class NavigatorSwiftDemoUITests: XCTestCase {
	private enum Constants {
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
		static let dismissAll = "dismissAll"
		static let popToRoot = "popToRoot"
		static let rootModal = "root modal"
		static let rootSet2Scenes = "root set 2 scenes"
		static let rootModalNav = "root modalNav"
		static let rootModalNavPush = "root modalNav push"
	}

	private enum TestsCases {
		static let dismiss = [Constants.modalDismissFirst, Constants.modalDismissScene, Constants.modalModalDismissAll]
		static let pop = [Constants.pushPop, Constants.pushPushPopToRoot]
	}

	var app: XCUIApplication!
	
	override func setUp() {
		super.setUp()
		
		continueAfterFailure = true
		app = XCUIApplication()
		app.launchArguments = [Constants.uiTesting]
		app.launch()
	}


	func test_modal() {
		//when
		tapCell(Constants.modal)

		//then
		assertState("modal 1")
	}

	func test_modalNav() {
		//when
		tapCell(Constants.modalNav)

		//then
		assertState("modalNav 1")
	}

	func test_push() {
		//when
		tapCell(Constants.push)

		//then
		assertState("push 1")
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

	func testGivenRootModal_tapRootModal_recycle() {
		//given
		let state = Constants.rootModal
		let finalState = "modal 2"
		tapCell(state)

		//when
		wait(finalState)
		tapCell(state)

		//then
		assertState(finalState)
	}

	func testGivenRootModalNav_tapRootModalNav_recycle() {
		//given
		let state = Constants.rootModalNav
		let finalState = "modalNav 2"
		tapCell(state)

		//when
		wait(finalState)
		tapCell(state)

		//then
		assertState(finalState)
	}

	func testGivenRootModalNavPush_tapRootModalNavPush_recycle() {
		//given
		let state = Constants.rootModalNavPush
		let finalState = "push 3"
		tapCell(state)

		//when
		wait(finalState)
		tapCell(state)

		//then
		assertState(finalState)
	}

	func testGivenRootSet2Scenes_tapRootSet2Scenes_recycle() {
		//given
		let state = Constants.rootSet2Scenes
		let finalState = "root set 2 scenes 3"
		tapCell(state)

		//when
		wait(finalState)
		tapCell(state)

		//then
		assertState(finalState)
	}

	// Modal

	func testGivenModal_rootModal_recycle() {
		//given
		tapCell(Constants.modal)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 1")
	}

	func testGivenModalModal_rootModal_recycle() {
		//given
		tapCell(Constants.modalModal)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 1")
	}

	func testGivenPush_rootModal_doesNotRecycle() {
		//given
		tapCell(Constants.push)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 3")
	}

	func testGivenPushPush_rootModal_doesNotRecycle() {
		//given
		tapCell(Constants.pushPush)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 4")
	}

	func testGivenModalNav_rootModal_doesNotRecycle() {
		//given
		tapCell(Constants.modalNav)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 3")
	}

	func testGivenModalModalNav_rootModal_recycle() {
		//given
		tapCell(Constants.modal)
		tapCell(Constants.modalNav)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 1")
	}

	func testGivenModalNavPush_rootModal_doesNotRecycle() {
		//given
		tapCell(Constants.modalNav)

		//when
		tapCell(Constants.rootModalNavPush)

		//then
		assertState("push 4")
	}

	// RootModalNavPush

	func testGivenModal_tapRootModalNavPush_doesNotRecycle() {
		//given
		tapCell(Constants.modal)

		//when
		tapCell(Constants.rootModalNavPush)

		//then
		assertState("push 4")
	}

	func testGivenPush_tapRootModalNavPush_doesNotRecycle() {
		//given
		tapCell(Constants.push)

		//when
		tapCell(Constants.rootModalNavPush)

		//then
		assertState("push 4")
	}

	func testGivenPushPush_tapRootModalNavPush_doesNotRecycle() {
		//given
		tapCell(Constants.pushPush)

		//when
		tapCell(Constants.rootModalNavPush)

		//then
		assertState("push 5")
	}

	func testGivenModalNav_tapRootModalNavPush_recycle() {
		//given
		tapCell(Constants.modalNav)

		//when
		tapCell(Constants.rootModalNavPush)

		//then
		assertState("push 4")
	}

	func testGivenModalNavModalNav_tapPushPush_pushScenes() {
		//given
		tapCell(Constants.modalNav)
		tapCell(Constants.modalNav)

		//when
		tapCell(Constants.pushPush)

		//then
		assertState("push 4")
	}


	func testGivenModalModalModalModal_tapDismissAll_dismissAll() {
		//given
		tapCell(Constants.modalModal)
		tapCell(Constants.modalModal)

		//when
		tapCell(Constants.dismissAll)

		//then
		assertState("root")
	}

	func testGivenPushPushModalModalModalNav_tapRootModal_doesNotRecycle() {
		//given
		tapCell(Constants.pushPush)
		tapCell(Constants.modalModal)
		tapCell(Constants.modalNav)

		//when
		tapCell(Constants.rootModal)

		//then
		assertState("modal 7")
	}

	// PopToRoot

	func testGivenPushPushPushPush_tapPopToRoot_popToRoot() {
		//given
		tapCell(Constants.pushPush)
		tapCell(Constants.pushPush)

		//when
		tapCell(Constants.popToRoot)

		//then
		assertState("root")
	}
}

extension NavigatorSwiftDemoUITests {
	func tapCell(_ cell: String) {
		XCUIApplication().collectionViews.staticTexts[cell].firstMatch.tap()
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
}
