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
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
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
	func testGivenAnySceneNoRootViewController_changeStackOneScene_installStack() {
		// given
		let view = Constants.anyView
		let mockSceneOne = givenMockScene(name: "A", view: view)
		givenStubbedWindow()

		// when
		sut.changeStack(toScenes: [mockSceneOne])

		// then
		XCTAssertEqual(sut.viewControllerContainer!.visibleNavigationController.visibleViewController!, view)
		verify(mockWindow).makeKeyAndVisible()
	}

	func testGivenRootScene_isRootViewController_returnTrue() {
		//given
		givenStubbedWindow()
		let rootScene = givenRootScene()

		// when
		let isRoot = sut.isRootViewController(matching: rootScene)

		// then
		XCTAssertTrue(isRoot)
	}

	func testGivenRootScene_isRootViewControllerWithAnotherScene_returnFalse() {
		//given
		givenStubbedWindow()
		givenRootScene()
		let anotherScene = givenMockScene(name: Constants.anyOtherScene)

		// when
		let isRoot = sut.isRootViewController(matching: anotherScene)

		// then
		XCTAssertFalse(isRoot)
	}

	func testGivenNoRootScene_isRootViewController_returnFalse() {
		//given
		givenStubbedWindow()
		let scene = givenMockScene()

		// when
		let isRoot = sut.isRootViewController(matching: scene)

		// then
		XCTAssertFalse(isRoot)
	}

	func testGivenNoRootScene_installScene_setRootViewController() {
		//given
		givenStubbedWindow()
		let scene = givenMockScene()

		// when
		sut.installScene(asRootViewController: scene)
		let rootViewController = visibleViewController(for: sut)

		// then
		XCTAssertEqual(Constants.anyView, rootViewController)
	}

	func testGivenRootScene_installScene_setRootViewController() {
		//given
		givenStubbedWindow()
		givenRootScene()
		let anotherScene = givenMockScene(name: Constants.anyOtherScene, view: Constants.anyOtherView)
	
		// when
		sut.installScene(asRootViewController: anotherScene)
		let rootViewController = visibleViewController(for: sut)

		// then
		XCTAssertEqual(Constants.anyOtherView, rootViewController)
	}

	func testGivenSceneWithModalPresentation_isViewControllerPresentedAsRequired_returnTrue() {
		// given
		let scene = givenMockScene(type: .modal, isViewControllerRecyclable: true)
		let viewController = givenViewController(for: scene)

		// when
		let isPresentedAsRequire = sut.isViewController(viewController, presentedAsRequire: scene)

		// then
		XCTAssertTrue(isPresentedAsRequire)
	}

	func testGivenSceneWithPushPresentation_isViewControllerPresentedAsRequired_returnTrue() {
		// given
		let scene = givenMockScene(type: .push, isViewControllerRecyclable: true)
		let viewController = givenViewController(for: scene)

		// when
		let isPresentedAsRequire = sut.isViewController(viewController, presentedAsRequire: scene)

		// then
		XCTAssertTrue(isPresentedAsRequire)
	}

	func testGivenSceneWithModalInsideNavigationPresentation_isViewControllerPresentedAsRequired_returnTrue() {
		// given
		let view = UIViewController()
		let scene = givenMockScene(view: view, type: .modalInsideNavigationBar, isViewControllerRecyclable: true)
		let viewController = givenViewController(for: scene)

		// when
		let isPresentedAsRequire = sut.isViewController(viewController, presentedAsRequire: scene)

		// then
		XCTAssertEqual(view, viewController)
		XCTAssertTrue(isPresentedAsRequire)
	}

	func testGivenEmptyNavigationController_visibleViewController_returnNavigationController() {
		// given
		let nav = UINavigationController()

		// when
		let visibleView = sut.visibleViewController(from: nav)

		// then
		XCTAssertEqual(nav, visibleView)
	}

	func testGivenNonEmptyNavigationController_visibleViewController_returnRootViewController() {
		// given
		let view = UIViewController()
		let nav = UINavigationController(rootViewController: view)

		// when
		let visibleView = sut.visibleViewController(from: nav)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenEmptyTabBarController_visibleViewController_returnTabBarController() {
		// given
		let tabBar = UITabBarController()

		// when
		let visibleView = sut.visibleViewController(from: tabBar)

		// then
		XCTAssertEqual(tabBar, visibleView)
	}

	func testGivenNonEmptyTabBarController_visibleViewController_returnRootViewController() {
		// given
		let view = UIViewController()
		let tabBar = UITabBarController()
		tabBar.setViewControllers([view], animated: false)

		// when
		let visibleView = sut.visibleViewController(from: tabBar)

		// then
		XCTAssertEqual(view, visibleView)
	}

	func testGivenViewController_visibleViewController_returnViewController() {
		// given
		let view = UIViewController()

		// when
		let visibleView = sut.visibleViewController(from: view)

		// then
		XCTAssertEqual(view, visibleView)
	}
}

// MARK: Helpers general

extension SceneRendererTests {
	func visibleViewController(for renderer: SceneRenderer) -> UIViewController {
		return renderer
			.viewControllerContainer!
			.visibleNavigationController
			.visibleViewController!
	}
}

// MARK: Helpers Scenes

extension SceneRendererTests {
	func givenStubbedWindow() {
		stub(mockWindow) { stub in
			when(stub.makeKeyAndVisible()).then(Constants.anyBlock)
		}
	}

	func givenMockScene(name: SceneName = Constants.anyScene,
	                    view: UIViewController = Constants.anyView,
	                    type: ScenePresentationType = .modal,
	                    isViewControllerRecyclable: Bool = false) -> MockScene {
		stub(mockSceneHandler) { stub in
			when(stub.buildViewController(with: any())).thenReturn(view)
			when(stub.name.get).thenReturn(name)
			when(stub.isViewControllerRecyclable.get).thenReturn(isViewControllerRecyclable)
		}

		return MockScene(sceneHandler: mockSceneHandler,
		                 parameters: [:],
		                 type: type,
		                 animated: false)
	}

	@discardableResult
	func givenRootScene() -> Scene {
		let rootScene = givenMockScene()
		sut.changeStack(toScenes: [rootScene])
		return rootScene
	}
}

// MARK: Helpers general

extension SceneRendererTests {
	func givenViewController(for scene: Scene) -> UIViewController {
		let nav = givenNavigationController(with: scene.sceneHandler.name)
		let vc = scene.sceneHandler._buildViewController(with: [:])

		_ = vc.view.alpha
		_ = vc.navigationController?.view.alpha

		switch scene.type {
		case .modal:
			nav.present(vc, animated: false, completion: nil)
		case .push:
			nav.pushViewController(vc, animated: false)
		case .modalInsideNavigationBar:
			nav.present(UINavigationController(rootViewController: vc), animated: false, completion: nil)
		}

		return vc
	}

	func givenViewController(with sceneName: SceneName) -> UIViewController {
		let vc = UIViewController()
		vc.sceneName = sceneName.value
		return vc
	}

	func givenNavigationController(with sceneName: SceneName, count: Int = 1) -> UINavigationController {
		let nav = UINavigationController()

		for _ in 0..<count {
			nav.viewControllers.append(givenViewController(with: sceneName))
		}

		return nav
	}

	func givenTabBarController(with sceneName: SceneName, count: Int = 1) -> UITabBarController {
		let tab = UITabBarController()
		tab.viewControllers = []

		for _ in 0..<count {
			tab.viewControllers?.append(givenViewController(with: sceneName))
		}

		return tab
	}
}
