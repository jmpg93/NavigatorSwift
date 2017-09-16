//
//  SceneOperationTests.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

@testable import NavigatorSwift
import XCTest
import Cuckoo

class SceneOperationTests: XCTestCase {
	public enum Constants {
		static let anyScene: SceneName = "anyScene"
		static let anyOtherScene: SceneName = "anyOtherScene"
		static let anyBlock: () -> Void = { }
		static let anyView = UIViewController()
		static let anyOtherView = UIViewController()
	}

	lazy var mockInstallOperation: MockSceneOperation = self.givenMockOperation()
	lazy var mockDismissAllOperation: MockSceneOperation = self.givenMockOperation()
	lazy var mockRecycleOperation: MockSceneOperation = self.givenMockOperation()
}

extension SceneOperationTests {
	func givenMockViewControllerContainer(root: UINavigationController) -> MockViewControllerContainer {
		let mockViewControllerContainer = MockViewControllerContainer()

		stub(mockViewControllerContainer) { stub in
			when(stub.rootViewController.get).thenReturn(root)
			when(stub.firstLevelNavigationControllers.get).thenReturn([root])
			when(stub.visibleNavigationController.get).thenReturn(root)
		}

		return mockViewControllerContainer
	}

	func givenMockSceneRenderer(window: UIWindow, root: UINavigationController, scene: SceneName? = nil) -> MockSceneRenderer {
		if let scene = scene {
			root.visibleViewController!.sceneName = scene.value
		}

		let mockContainer = givenMockViewControllerContainer(root: root)

		let mockSceneRenderer = MockSceneRenderer(window: window, viewControllerContainer: mockContainer)

		stub(mockSceneRenderer) { stubRenderer in
			when(stubRenderer.dismissAll(animated: any())).thenReturn(mockDismissAllOperation)
			when(stubRenderer.install(scene: any())).thenReturn(mockInstallOperation)
			when(stubRenderer.recycle(scenes: any())).thenReturn(mockRecycleOperation)

			when(stubRenderer.rootViewController.get).thenReturn(root)
			when(stubRenderer.visibleNavigationController.get).thenReturn(mockContainer.visibleNavigationController)
			when(stubRenderer.viewControllerContainer.get).thenReturn(mockContainer)
			when(stubRenderer.viewControllerContainer.set(any())).then { container in
				when(stubRenderer.visibleNavigationController.get).thenReturn(container.visibleNavigationController)
			}
		}

		return mockSceneRenderer
	}

	func givenMockSceneHandler(name: SceneName,
	                           view: UIViewController,
	                           isViewControllerRecyclable: Bool = false) -> MockSceneHandler {
		let mockSceneHandler = MockSceneHandler()

		stub(mockSceneHandler) { stub in
			when(stub.name.get).thenReturn(name)
			when(stub.isViewControllerRecyclable.get).thenReturn(isViewControllerRecyclable)
			when(stub.buildViewController(with: any())).thenReturn(view)
		}

		return mockSceneHandler
	}

	func givenMockScene(name: SceneName,
	                    view: UIViewController,
	                    type: ScenePresentationType,
	                    isViewControllerRecyclable: Bool = false) -> MockScene {
		view.sceneName = name.value
		let mockSceneHandler = givenMockSceneHandler(name: name,
		                                             view: view,
		                                             isViewControllerRecyclable: isViewControllerRecyclable)

		let mockScene = MockScene(sceneHandler: mockSceneHandler, parameters: [:], type: type, animated: false)
		
		return mockScene
	}

	func givenMockScenes() -> [Scene] {
		return [
			givenMockScene(name: Constants.anyScene, view: Constants.anyView, type: .push),
			givenMockScene(name: Constants.anyOtherScene, view: Constants.anyOtherView, type: .push)
		]
	}

	func givenMockOperation() -> MockSceneOperation {
		let mockOperation = MockSceneOperation()

		stub(mockOperation) { stub in
			when(stub.execute(with: any())).then { completion in
				completion?()
			}
			when(stub.then(any())).then { op in
				return OrderedSceneOperation(first: mockOperation, last: op)
			}
		}

		return mockOperation
	}
}
