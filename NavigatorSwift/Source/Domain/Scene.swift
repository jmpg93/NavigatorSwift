//
//  Scene.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class Scene {
	public unowned let sceneHandler: SceneHandler
	public let parameters: Parameters
	public let type: ScenePresentationType
	public let isAnimated: Bool
	
	public init(sceneHandler: SceneHandler,
	            parameters: Parameters,
	            type typePresentation: ScenePresentationType,
	            animated isAnimated: Bool) {
		self.parameters = parameters
		self.isAnimated = isAnimated
		self.sceneHandler = sceneHandler
		self.type = typePresentation
	}
}
