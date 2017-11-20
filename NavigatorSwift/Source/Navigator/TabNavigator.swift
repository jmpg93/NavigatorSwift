//
//  TabNavigator.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public final class TabNavigator: Navigator, NavigatorPreviewing {
	public let sceneProvider = SceneProvider()
	public let sceneRenderer: SceneRenderer

	public var previews: [UIView : (Preview, UIViewControllerPreviewing)] = [:]

	public init(window: UIWindow) {
		sceneRenderer = SceneRenderer(window: window, viewControllerContainer: TabBarContainer())
	}
}
