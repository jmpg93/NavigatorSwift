//
//  SceneState.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 5/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public struct SceneState {
	public let name: SceneName
	public let type: ScenePresentationType

	public init(name: SceneName, type: ScenePresentationType) {
		self.name = name
		self.type = type
	}
}
