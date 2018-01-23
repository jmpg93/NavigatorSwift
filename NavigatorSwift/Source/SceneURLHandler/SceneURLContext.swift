//
//  SceneURLContext.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 23/1/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public struct SceneURLContext {
	public let sceneName: SceneName
	public let parameters: Parameters
	public let type: ScenePresentationType
	public let isAnimated: Bool
	
	public init(sceneName: SceneName,
				parameters: Parameters,
				type: ScenePresentationType,
				isAnimated: Bool) {
		self.sceneName = sceneName
		self.parameters = parameters
		self.type = type
		self.isAnimated = isAnimated
	}
}
