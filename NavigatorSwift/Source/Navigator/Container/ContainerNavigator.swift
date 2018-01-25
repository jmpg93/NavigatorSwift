//
//  ContainerNavigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 23/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

final public class ContainerNavigator: Navigator, NavigatorPreviewing {
	public var previews: [UIView : (Preview, UIViewControllerPreviewing)] = [:]
	public let sceneProvider: SceneProvider
	public var sceneURLHandler: SceneURLHandler
	public let sceneOperationManager: SceneOperationManager

	public init(window: UIWindow,
				viewControllerContainer: ViewControllerContainer,
				sceneProvider: SceneProvider = SceneProvider(),
				sceneURLHandler: SceneURLHandler = EmptySceneURLHandler()) {
		sceneOperationManager = SceneOperationManager(window: window, viewControllerContainer: viewControllerContainer)
		self.sceneProvider = sceneProvider
		self.sceneURLHandler = sceneURLHandler
	}
}
