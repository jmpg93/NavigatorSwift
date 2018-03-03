//
//  NavigationRequest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class SceneBuilder<T: Navigator> {
	public let sceneProvider: SceneProvider
	
	private(set) var scenes: [Scene] = []
	var isAbsolute: Bool {
		return scenes
			.map { $0.type }
			.contains(.root)
	}

	public init(using builderBlock: SceneBuilderBlock<T>, sceneProvider: SceneProvider) {
		self.sceneProvider = sceneProvider
		builderBlock(self)
	}
}

// MARK: Public methods

public extension SceneBuilder {
	func root(_ sceneName: SceneName, parameters: Parameters = [:]) {
		add(sceneName, type: .root, parameters: parameters, animated: false)
	}

	func push(_ sceneName: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		add(sceneName, type: .push, parameters: parameters, animated: animated)
	}

	func present(_ sceneName: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		add(sceneName, type: .modal, parameters: parameters, animated: animated)
	}

	func presentNavigation(_ sceneName: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		add(sceneName, type: .modalNavigation, parameters: parameters, animated: animated)
	}

	func add(context: SceneContext) {
		add(context.sceneName, type: context.type, parameters: context.parameters, animated: context.isAnimated)
	}

	func add(_ sceneName: SceneName, type: ScenePresentationType, parameters: Parameters, animated: Bool) {
		let scene = sceneProvider.scene(with: sceneName, parameters: parameters, type: type, animated: animated)
		logTrace("[SceneBuilder] Added scene \(scene)")
		scenes.append(scene)
	}
}
