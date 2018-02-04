//
//  ScenePresentationState.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 4/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public struct ScenePresentationState {
	public let name: SceneName
	public let type: ScenePresentationType

	public init(name: SceneName, type: ScenePresentationType) {
		self.name = name
		self.type = type
	}
}

// MARK: - Internal methods

extension ScenePresentationState {
	init(scene: Scene) {
		self.init(name: scene.sceneHandler.name, type: scene.type)
	}
}

// MARK: - Array utils

extension Array where Element: ScenePresentationState {
	func dropping(top: ScenePresentationType) -> [ScenePresentationState] {
		return self
	}

	func dropping(bottom: ScenePresentationType) -> [ScenePresentationState] {
		return self
	}

	func dropping(first: ScenePresentationType) -> [ScenePresentationState] {
		return reversed()
	}

	func adding(scene: Scene) -> [ScenePresentationState] {
		return self + [ScenePresentationState(scene: scene)]
	}
}
