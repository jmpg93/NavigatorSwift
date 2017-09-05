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

let globalWindow = UIWindow()

let globalNavigator = Navigator(sceneMatcher: SceneMatcher(),
                                sceneRenderer: SceneRenderer(window: globalWindow),
                                sceneHandlerRegisters: FeaturesSceneHandlerRegisters(sceneHandlerRegisters: [LoginSceneRegisterer(), CollectionSceneRegisterer()]),
                                navigationRequestProvider: DefaultNavigationRequestProvider())

