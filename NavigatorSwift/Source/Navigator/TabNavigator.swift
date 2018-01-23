//
//  TabNavigator.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public final class TabNavigator: Navigator, NavigatorPreviewing {
	public var previews: [UIView : (Preview, UIViewControllerPreviewing)] = [:]
	public let sceneProvider = SceneProvider()
	public var sceneURLHandler: SceneURLHandler = EmptySceneURLHandler()
	public let sceneOperationManager: SceneOperationManager

	public init(window: UIWindow) {
		sceneOperationManager = SceneOperationManager(window: window, viewControllerContainer: TabBarContainer())
	}
}
