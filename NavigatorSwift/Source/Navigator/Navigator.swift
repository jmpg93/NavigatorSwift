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
}

// MARK: - Navigating with URLs

public extension Navigator {
	@discardableResult
	func absoluteNavigation(to url: URL, parameters: Parameters = [:], completion: CompletionBlock? = nil) -> Bool {
		var urlHandled = false
		let scenesInURL = matchScenes(from: url, parameters: parameters)

		if scenesInURL.count > 0 {
			urlHandled = true
			sceneRenderer.set(scenes: scenesInURL, completion: completion)
		}

		return urlHandled
	}

	@discardableResult
	func relativeNavigation(to url: URL, parameters: Parameters = [:], completion: CompletionBlock? = nil) -> Bool {
		var urlHandler = false
		let scenesInURL = matchScenes(from: url, parameters: parameters)

		if scenesInURL.count > 0 {
			urlHandler = true
			sceneRenderer.add(scenes: scenesInURL, completion: completion)
		}

		return urlHandler
	}
}

// MARK: - Navigating with Scene names

public extension Navigator {
	@discardableResult
	func pushSceneNamed(_ name: SceneName,
	                    parameters: Parameters = [:],
	                    animated: Bool = true,
	                    completion: CompletionBlock? = nil) -> Bool {

		let navigationRequest = navigationRequestProvider.navigationRequest { builder in
			builder.appendPushScene(withName: name, parameters: parameters, animated: animated)
		}

		return relativeNavigation(to: navigationRequest.url,
		                          parameters: navigationRequest.allParameters,
		                          completion: completion)
	}

	@discardableResult
	func presentSceneNamed(_ name: SceneName,
	                       parameters: Parameters = [:],
	                       animated: Bool = true,
	                       completion: CompletionBlock? = nil) -> Bool {

		let navigationRequest = navigationRequestProvider.navigationRequest { builder in
			builder.appendModalScene(withName: name, parameters: parameters, animated: animated)
		}

		return relativeNavigation(to: navigationRequest.url,
		                          parameters: navigationRequest.allParameters,
		                          completion: completion)
	}

	@discardableResult
	func presentNavigationController(withSceneNamed name: SceneName,
	                                 parameters: Parameters = [:],
	                                 animated: Bool = true,
	                                 completion: CompletionBlock? = nil) -> Bool {

		let navigationRequest = navigationRequestProvider.navigationRequest { builder in
			builder.appendModalWithNavigationScene(withName: name, parameters: parameters, animated: animated)
		}

		return relativeNavigation(to: navigationRequest.url,
		                          parameters: navigationRequest.allParameters,
		                          completion: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

public extension Navigator {
	@discardableResult
	func popScene(animated: Bool, completion: CompletionBlock? = nil) -> UIViewController? {
		return sceneRenderer.pop(animated: animated, completion: completion)
	}

	@discardableResult
	func popToRootScene(animated: Bool, completion: CompletionBlock? = nil) -> [UIViewController]? {
		return sceneRenderer.popToRoot(animated: animated, completion: completion)
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
	func matchScenes(from url: URL, parameters: Parameters) -> [Scene] {
		return sceneMatcher.matches(from: url, externalParameters: parameters)
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
