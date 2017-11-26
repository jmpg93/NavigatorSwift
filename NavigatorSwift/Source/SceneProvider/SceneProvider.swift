//
//  SceneProvider.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class SceneProvider {
	/// Contains all the scenes registered in the system by their name.
	fileprivate var sceneHandlersByName: [SceneName: SceneHandler] = [:]
}

// MARK: - Internal Methods

extension SceneProvider {
	func registerScene(for sceneHandler: SceneHandler) {
		assert(sceneHandlersByName[sceneHandler.name] == nil, "Already registered scene named \(sceneHandler.name)")
		sceneHandlersByName[sceneHandler.name] = sceneHandler
	}

	func scenes(with builder: (SceneBuilder) -> Void) -> (scenes: [Scene], isAbsolutely: Bool) {
		let sceneBuilder = SceneBuilder(using: builder, sceneProvider: self)
		return (sceneBuilder.scenes, sceneBuilder.isAbsolutely)
	}

	func scene(with name: SceneName, parameters: Parameters = [:], type: ScenePresentationType, animated: Bool = true) -> Scene {
		guard let sceneHandler = sceneHandlersByName[name] else {
			fatalError("The scene \(name) was not registered.")
		}
		return Scene(sceneHandler: sceneHandler, parameters: parameters, type: type, animated: animated)
	}
}
