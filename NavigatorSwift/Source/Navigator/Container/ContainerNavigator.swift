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
	public var previews: [UIView : Preview] = [:]
	public var interceptors: [SceneOperationInterceptor] = []

	public let provider: SceneProvider
	public let urlHandler: SceneURLHandler
	public let manager: SceneOperationManager

	public init(window: UIWindow,
				sceneURLHandler: SceneURLHandler = EmptySceneURLHandler()) {
		let sceneOperationManager = SceneOperationManager(window: window)
		self.manager = sceneOperationManager
		self.urlHandler = sceneURLHandler

		self.provider = SceneProvider(manager: sceneOperationManager)
	}
}
