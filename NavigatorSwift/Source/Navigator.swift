//
//  Navigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class Navigator {
	let sceneMatcher: SceneMatcher
	let sceneRenderer: SceneRenderer
	let navigationRequestProvider: NavigationRequestProvider

	init(sceneMatcher: SceneMatcher, sceneRenderer: SceneRenderer,
	     featuresSceneHandlerRegisters: FeaturesSceneHandlerRegisters,
	     navigationRequestProvider: NavigationRequestProvider) {
		self.sceneMatcher = sceneMatcher
		self.sceneRenderer = sceneRenderer
		self.navigationRequestProvider = navigationRequestProvider

		registerSceneHandlerRegisters(featuresSceneHandlerRegisters.featuresSceneHandlerRegisters)
	}
}

// MARK: - SceneHandler Registrar

extension Navigator {
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

// MARK: - Navigating with URLs

extension Navigator {
	func navigateToScene(withAbsoluteURL url: URL, parameters: Parameters, completion: CompletionBlock? = nil) -> Bool {
		var urlHandled = false
		let scenesInURL = matchScenes(from: url, parameters: parameters)

		if scenesInURL.count > 0 {
			urlHandled = true
			sceneRenderer.changeStack(toScenes: scenesInURL, completion: completion)
		}

		return urlHandled
	}

	func navigateToScene(withRelativeURL url: URL, parameters: Parameters, completion: CompletionBlock? = nil) -> Bool {
		var urlHandler = false
		let scenesInURL = matchScenes(from: url, parameters: parameters)

		if scenesInURL.count > 0 {
			urlHandler = true
			sceneRenderer.addScenesOntoStack(scenesInURL, completion: completion)
		}

		return urlHandler
	}
}

// MARK: - Navigating with Scene names

extension Navigator {
	func pushSceneNamed(_ name: String) -> Bool {
		return pushSceneNamed(name, parameters: [:], animated: true)
	}

	func pushSceneNamed(_ name: String, parameters: Parameters, animated: Bool) -> Bool {
		let navigationRequest = navigationRequestProvider.navigationRequest { builder in
			builder.appendPushScene(withName: name, parameters: parameters, animated: animated)
		}

		return navigateToScene(withRelativeURL: navigationRequest.url, parameters: navigationRequest.allParameters, completion: nil)
	}

	func presentSceneNamed(_ name: String, completion: CompletionBlock? = nil) -> Bool {
		return presentSceneNamed(name, parameters: [:], animated: true, completion: completion)
	}

	func presentSceneNamed(_ name: String, parameters: Parameters, animated: Bool, completion: CompletionBlock? = nil) -> Bool {
		let navigationRequest = navigationRequestProvider.navigationRequest { builder in
			builder.appendModalScene(withName: name, parameters: parameters, animated: animated)
		}

		return navigateToScene(withRelativeURL: navigationRequest.url, parameters: navigationRequest.allParameters, completion: completion)
	}

	func presentNavigationController(withSceneNamed name: String, completion: CompletionBlock? = nil) -> Bool {
		return presentNavigationController(withSceneNamed: name, parameters: [:], animated: true, completion: completion)
	}

	func presentNavigationController(withSceneNamed name: String, parameters: Parameters, animated: Bool, completion: CompletionBlock? = nil) -> Bool {
		let navigationRequest = navigationRequestProvider.navigationRequest { builder in
			builder.appendModalWithNavigationScene(withName: name, parameters: parameters, animated: animated)
		}

		return navigateToScene(withRelativeURL: navigationRequest.url, parameters: navigationRequest.allParameters, completion: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

extension Navigator {
	func popScene(animated: Bool, completion: CompletionBlock? = nil) -> UIViewController? {
		return sceneRenderer.popScene(animated: animated, completion: completion)
	}

	func popToRootScene(animated: Bool, completion: CompletionBlock? = nil) -> [UIViewController]? {
		return sceneRenderer.popToRootScene(animated: animated, completion: completion)
	}

	func dismissScene(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.dismissScene(animated: animated, completion: completion)
	}

	func dismissSceneNamed(_ name: String, animated: Bool, completion: CompletionBlock? = nil) {
		if let scene = sceneMatcher.scene(withName: name, typePresentation: .modal, animated: true) {
			sceneRenderer.dismiss(scene, animated: animated, completion: completion)
		} else {
			assert(false, "Can not dismiss scene named \(name) becuase there is not a scene registered for this name.")
		}
	}
}
// MARK: - Private

extension Navigator {
	func matchScenes(from url: URL, parameters: Parameters) -> [Scene] {
		return sceneMatcher.matches(from: url, externalParameters: parameters)
	}
}
