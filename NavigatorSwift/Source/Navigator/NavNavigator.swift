//
//  NavNavigator.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class NavNavigator: Navigator {
	public let sceneProvider = SceneProvider()
	public let sceneRenderer: SceneRenderer

	public init(window: UIWindow) {
		sceneRenderer = SceneRenderer(window: window, viewControllerContainer: NavigationBarContainer())
	}
}

