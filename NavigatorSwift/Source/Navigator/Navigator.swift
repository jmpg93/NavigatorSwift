//
//  Navigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol Navigator {
	var sceneProvider: SceneProvider { get }
	var sceneRenderer: SceneRenderer { get }
}

// MARK: - Navigating with Scene names

public extension Navigator {
	func push(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		guard let scene = sceneProvider.scene(with: name, parameters: parameters, type: .push, animated: animated) else { return }
		navigate(to: scene, completion: completion)
	}

	func present(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		guard let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modal, animated: animated) else { return }
		navigate(to: scene, completion: completion)
	}

	func presentNavigationController(using name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		guard let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modalNavigation, animated: animated) else { return }
		navigate(to: scene, completion: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

public extension Navigator {
	func pop(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.pop(animated: animated).execute(with: completion)
	}

	func popToRoot(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.popToRoot(animated: animated).execute(with: completion)
	}

	func dismiss(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.dismiss(animated: animated).execute(with: completion)
	}

	func dismiss(_ name: SceneName, animated: Bool, completion: CompletionBlock? = nil) {
		guard let scene = sceneProvider.scene(with: name, type: .modal, animated: animated) else { return }
		sceneRenderer.dismiss(scene: scene, animated: animated).execute(with: completion)
	}

	func dismissAll(animated: Bool, completion: CompletionBlock? = nil) {
		sceneRenderer.dismissAll(animated: animated).execute(with: completion)
	}
}

// MARK: - Navigate with builder

public extension Navigator {
	func navigate(using builder: (SceneBuilder) -> Void, completion: CompletionBlock? = nil) {
		let scenes = sceneProvider.scenes(with: builder)
		navigate(to: scenes, completion: completion)
	}
}

public extension Navigator {
	func deepLink(url: URL, completion: CompletionBlock?) {

	}
}

// MARK: - SceneHandler Registrar

public extension Navigator {
	func register(_ sceneHandler: SceneHandler) {
		sceneProvider.registerScene(for: sceneHandler)
	}

	func register(_ sceneHandlers: [SceneHandler]) {
		for sceneHandler in sceneHandlers {
			register(sceneHandler)
		}
	}
}

// MARK: - Preview Registrar

public extension Navigator {
	func preview(scene: SceneName, parameters: Parameters = [:], completion: CompletionBlock? = nil) -> UIViewControllerPreviewingDelegate? {
		guard let scene = sceneProvider.scene(with: scene, parameters: parameters, type: .modal, animated: true)
			else { return nil }

		return Preview(handler: scene.sceneHandler, parametes: parameters, completion: completion)
	}
}

// MARK: - Navigating with Scenes

extension Navigator {
	func replace(with scene: Scene, completion: CompletionBlock? = nil) {
		replace(with: [scene], completion: completion)
	}
	
	func replace(with scenes: [Scene], completion: CompletionBlock? = nil) {
		sceneRenderer.set(scenes: scenes).execute(with: completion)
	}
	
	func navigate(to scene: Scene, completion: CompletionBlock? = nil) {
		navigate(to: [scene], completion: completion)
	}
	
	func navigate(to scenes: [Scene], completion: CompletionBlock? = nil) {
		sceneRenderer.add(scenes: scenes).execute(with: completion)
	}
}
