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
