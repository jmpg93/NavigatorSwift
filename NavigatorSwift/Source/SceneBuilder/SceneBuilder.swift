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
	func root(name: SceneName, parameters: Parameters = [:]) {
		add(scene: name, type: .root, parameters: parameters, animated: false)
	}

	func push(name: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		add(scene: name, type: .push, parameters: parameters, animated: animated)
	}

	func present(name: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		add(scene: name, type: .modal, parameters: parameters, animated: animated)
	}

	func presentNavigation(name: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		add(scene: name, type: .modalNavigation, parameters: parameters, animated: animated)
	}

	func absolutely() {
		isAbsolutely = true
	}

	func relatively() {
		isAbsolutely = false
	}
}

// MARK: - Public methods

private extension SceneBuilder {
	func add(scene name: SceneName, type: ScenePresentationType, parameters: Parameters, animated: Bool) {
		guard let scene = sceneProvider.scene(with: name, parameters: parameters, type: type, animated: animated) else { return }
		scenes.append(scene)
	}
}
