//
//  NavigationRequest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class SceneBuilder {
	fileprivate let sceneProvider: SceneProvider
	
	fileprivate(set) var scenes: [Scene] = []
	fileprivate(set) var isAbsolutely = false

	public init(using builderBlock: SceneBuilderBlock, sceneProvider: SceneProvider) {
		self.sceneProvider = sceneProvider
		builderBlock(self)
	}
}

// MARK: - Public methods

public extension SceneBuilder {
	func root(_ sceneName: SceneName, parameters: Parameters = [:]) {
		isAbsolutely = true
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
}

// MARK: - Public methods

private extension SceneBuilder {
	func add(_ sceneName: SceneName, type: ScenePresentationType, parameters: Parameters, animated: Bool) {
		let scene = sceneProvider.scene(with: sceneName, parameters: parameters, type: type, animated: animated)
		scenes.append(scene)
	}
}
