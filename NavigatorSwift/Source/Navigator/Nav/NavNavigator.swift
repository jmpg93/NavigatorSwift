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
	public let sceneProvider: SceneProvider
	public var sceneURLHandler: SceneURLHandler
	public let sceneOperationManager: SceneOperationManager

	public init(window: UIWindow,
				navigationBarContainer: NavigationBarContainer,
				sceneProvider: SceneProvider = SceneProvider(),
				sceneURLHandler: SceneURLHandler = EmptySceneURLHandler()) {
		sceneOperationManager = SceneOperationManager(window: window, viewControllerContainer: navigationBarContainer)
		self.sceneProvider = sceneProvider
		self.sceneURLHandler = sceneURLHandler
	}
}
