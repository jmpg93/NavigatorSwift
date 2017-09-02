//
//  Navigator.swift
//  NavigationSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift
import UIKit

func navigator(for window: UIWindow) -> Navigator {
	let requestProvider = DefaultNavigationRequestProvider()
	let sceneMatcher = SceneMatcher()
	let sceneRenderer = SceneRenderer(window: window)
	let sceneHandlerRegisters = FeaturesSceneHandlerRegisters(sceneHandlerRegisters: [LoginSceneRegisterer()])

	return Navigator(sceneMatcher: sceneMatcher,
	                          sceneRenderer: sceneRenderer,
	                          sceneHandlerRegisters: sceneHandlerRegisters,
	                          navigationRequestProvider: requestProvider)
}

