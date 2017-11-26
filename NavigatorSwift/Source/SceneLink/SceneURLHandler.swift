//
//  SceneURLHandler.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 13/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol SceneURLHandler {
	func scenes(from url: URL) -> [SceneName]
}
