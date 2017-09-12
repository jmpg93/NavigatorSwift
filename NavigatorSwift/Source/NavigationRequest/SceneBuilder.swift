//
//  NavigationRequest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class SceneBuilder {
	fileprivate(set) var scenes: [Scene] = []
	fileprivate let sceneProvider: SceneProvider

	public init(using builderBlock: SceneBuilderBlock, sceneProvider: SceneProvider) {
		self.sceneProvider = sceneProvider
		builderBlock(self)
	}
}

// MARK: - Public methods

public extension SceneBuilder {
	func appendPush(name: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		appendScene(name: name, type: .push, parameters: parameters, animated: animated)
	}

	func appendModal(name: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		appendScene(name: name, type: .modal, parameters: parameters, animated: animated)
	}

	func appendModalWithNavigation(name: SceneName, parameters: Parameters = [:], animated: Bool = true) {
		appendScene(name: name, type: .modalNavigation, parameters: parameters, animated: animated)
	}
}

// MARK: - Public methods

private extension SceneBuilder {
	func appendScene(name: SceneName, type: ScenePresentationType, parameters: Parameters, animated: Bool) {
		guard let scene = sceneProvider.scene(with: name, parameters: parameters, type: type, animated: animated) else {
			return
		}
		scenes.append(scene)
	}
}
