//
//  ContainerNavigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 23/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

final public class ContainerNavigator: Navigator, NavigatorPreviewing {
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
