//
//  Navigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class Navigator {
	fileprivate let sceneMatcher: SceneMatcher
	fileprivate let sceneRenderer: SceneRenderer
	fileprivate let navigationRequestProvider: NavigationRequestProvider

	public init(sceneMatcher: SceneMatcher,
	            sceneRenderer: SceneRenderer,
	            sceneHandlerRegisters: SceneHandlerRegisters,
	            navigationRequestProvider: NavigationRequestProvider) {
		self.sceneMatcher = sceneMatcher
		self.sceneRenderer = sceneRenderer
		self.navigationRequestProvider = navigationRequestProvider

		registerSceneHandlerRegisters(sceneHandlerRegisters.sceneHandlerRegisters)
	}

	public init(window: UIWindow, sceneHandlerRegisters: SceneHandlerRegisters) {
		self.sceneRenderer = SceneRenderer(window: window, viewControllerContainer: NavigationBarContainer())
		self.sceneMatcher = SceneMatcher()
		self.navigationRequestProvider = DefaultNavigationRequestProvider()

		registerSceneHandlerRegisters(sceneHandlerRegisters.sceneHandlerRegisters)
	}
}

// MARK: - Navigating with URLs

public extension Navigator {
	@discardableResult
	func absoluteNavigation(using request: NavigationRequest, completion: CompletionBlock? = nil) -> Bool {
		var handled = false
		let scenes = matchScenes(from: request, externalParameters: request.allParameters)

		if scenes.count > 0 {
			handled = true
			sceneRenderer.set(scenes: scenes, completion: completion)
		}

		return handled
	}

	@discardableResult
	func relativeNavigation(using request: NavigationRequest, completion: CompletionBlock? = nil) -> Bool {
		var handled = false
		let scenes = matchScenes(from: request, externalParameters: request.allParameters)

		if scenes.count > 0 {
			handled = true
			sceneRenderer.add(scenes: scenes, completion: completion)
		}

		return handled
	}
}

// MARK: - Navigating with Scene names

public extension Navigator {
	@discardableResult
	func pushScene(_ name: SceneName,
	               parameters: Parameters = [:],
	               animated: Bool = true,
	               completion: CompletionBlock? = nil) -> Bool {

		let request = navigationRequestProvider.navigationRequest { builder in
			builder.appendPushScene(withName: name, parameters: parameters, animated: animated)
		}

		return relativeNavigation(using: request, completion: completion)
	}

	@discardableResult
	func presentScene(_ name: SceneName,
	                  parameters: Parameters = [:],
	                  animated: Bool = true,
	                  completion: CompletionBlock? = nil) -> Bool {

		let request = navigationRequestProvider.navigationRequest { builder in
			builder.appendModalScene(withName: name, parameters: parameters, animated: animated)
		}

		return relativeNavigation(using: request, completion: completion)
	}

	@discardableResult
	func presentNavigationController(using name: SceneName,
	                                 parameters: Parameters = [:],
	                                 animated: Bool = true,
	                                 completion: CompletionBlock? = nil) -> Bool {

		let request = navigationRequestProvider.navigationRequest { builder in
			builder.appendModalWithNavigationScene(withName: name, parameters: parameters, animated: animated)
		}

		return relativeNavigation(using: request, completion: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

public extension Navigator {
	func popScene(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.pop(animated: animated, completion: completion)
	}

	func popToRootScene(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.popToRoot(animated: animated, completion: completion)
	}

	func dismissScene(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.dismiss(animated: animated, completion: completion)
	}

	func dismissSceneNamed(_ name: SceneName, animated: Bool, completion: CompletionBlock? = nil) {
		if let scene = sceneMatcher.scene(withName: name, typePresentation: .modal, animated: true) {
			sceneRenderer.dismiss(scene: scene, animated: animated, completion: completion)
		} else {
			assert(false, "Can not dismiss scene named \(name) becuase there is not a scene registered for this name.")
		}
	}
}

// MARK: - Private

private extension Navigator {
	func matchScenes(from request: NavigationRequest, externalParameters: Parameters) -> [Scene] {
		return sceneMatcher.matches(from: request, externalParameters: externalParameters)
	}
}

// MARK: - SceneHandler Registrar

private extension Navigator {
	func registerSceneHandlerRegisters(_ sceneHandlersRegisters: [SceneHandlerRegistrable]) {
		for sceneHandlerRegistrar in sceneHandlersRegisters {
			registerSceneHandlers(from: sceneHandlerRegistrar.sceneHandlersToRegister())
		}
	}

	func registerSceneHandlers(from sceneHandlers: [SceneHandler]) {
		for sceneHandler in sceneHandlers {
			sceneMatcher.registerScene(for: sceneHandler)
		}
	}
}
