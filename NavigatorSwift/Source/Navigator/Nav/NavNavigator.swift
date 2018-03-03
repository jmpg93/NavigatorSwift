//
//  NavNavigator.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

final public class NavNavigator: Navigator, NavigatorPreviewing {
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
