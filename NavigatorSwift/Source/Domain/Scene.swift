//
//  Scene.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class Scene {
	let sceneHandler: SceneHandler //TODO: Set this unwnowed
	let parameters: Parameters
	let type: ScenePresentationType
	let isAnimated: Bool

	init(sceneHandler: SceneHandler,
	     parameters: Parameters,
	     type typePresentation: ScenePresentationType,
	     animated isAnimated: Bool) {
		self.parameters = parameters
		self.isAnimated = isAnimated
		self.sceneHandler = sceneHandler
		self.type = typePresentation
	}
}
