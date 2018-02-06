//
//  TabNavigator.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

final public class TabNavigator: Navigator, NavigatorPreviewing {
	public var previews: [UIView : (Preview, UIViewControllerPreviewing)] = [:]
	public var interceptors: [SceneOperationInterceptor] = []

	public let sceneProvider: SceneProvider
	public let sceneURLHandler: SceneURLHandler
	public let sceneOperationManager: SceneOperationManager

	public init(window: UIWindow,
				sceneURLHandler: SceneURLHandler = EmptySceneURLHandler()) {
		let sceneOperationManager = SceneOperationManager(window: window)
		self.sceneOperationManager = sceneOperationManager
		self.sceneURLHandler = sceneURLHandler

		self.sceneProvider = SceneProvider(manager: sceneOperationManager)
	}
}

// MARK: Public methods

public extension TabNavigator {
	public func setTabs(_ sceneContexts: [SceneContext]) {
		guard let tabBarContainer = sceneOperationManager.rootViewController as? TabBarContainer else { return }

		tabBarContainer.viewControllers = sceneContexts
			.map(sceneProvider.scene)
			.map(buildViewController)
	}
}

// MARK: Private methods

private extension TabNavigator {
	func buildViewController(scene: Scene) -> UIViewController {
		return UINavigationController(rootViewController: scene.view())
	}
}
