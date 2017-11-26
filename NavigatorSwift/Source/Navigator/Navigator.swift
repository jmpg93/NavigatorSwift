//
//  Navigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol Navigator: class {
	var sceneProvider: SceneProvider { get }
	var sceneRenderer: SceneRenderer { get }
	var sceneURLHandler: SceneURLHandler { get set }
}

// MARK: - Set root with Scene names

public extension Navigator {
	func root(_ scene: SceneName, parameters: Parameters = [:]) {
		guard let scene = sceneProvider.scene(with: scene, parameters: parameters, type: .modal) else { return }
		sceneRenderer.set(scenes: [scene]).execute(with: nil)
	}
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

	func presentNavigationController(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		guard let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modalNavigation, animated: animated) else { return }
		navigate(to: scene, completion: completion)
	}

	func reload(_ name: SceneName,  parameters: Parameters = [:], completion: CompletionBlock? = nil) {
		guard let scene = sceneProvider.scene(with: name, type: .reload) else { return }
		sceneRenderer.reload(scene:scene).execute(with: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

public extension Navigator {
	func pop(animated: Bool = true, completion: CompletionBlock? = nil) {
		sceneRenderer.pop(animated: animated).execute(with: completion)
	}

	func popToRoot(animated: Bool = true, completion: CompletionBlock? = nil) {
		sceneRenderer.popToRoot(animated: animated).execute(with: completion)
	}

	func dismiss(animated: Bool = true, completion: CompletionBlock? = nil) {
		sceneRenderer.dismiss(animated: animated).execute(with: completion)
	}

	func dismiss(_ name: SceneName, animated: Bool = true, completion: CompletionBlock? = nil) {
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
		let (scenes, navigateAbsolutly) = sceneProvider.scenes(with: builder)
		
		if navigateAbsolutly {
			replace(with: scenes, completion: completion)
		} else {
			navigate(to: scenes, completion: completion)
		}
	}
}

// MARK: - Deeplink

public extension Navigator {
	func url(_ url: URL, completion: CompletionBlock? = nil) {
		let builder = urlBuilder(for: url)
		navigate(using: builder, completion: completion)
	}
}

// MARK: - Transition

public extension Navigator {
	func transition(to scene: SceneName,
	                parameters: Parameters = [:],
	                with transition: Transition,
	                completion: CompletionBlock? = nil) {

		let type: ScenePresentationType = transition.insideNavigationBar ? .modalNavigation : .modal
		
		guard let scene = sceneProvider.scene(with: scene,
		                                      parameters: parameters,
		                                      type: type,
		                                      animated: true) else { return }

		sceneRenderer.transition(transition, to: scene).execute(with: completion)
	}
}

// MARK: - Popover

public extension Navigator {
	func popover(_ scene: SceneName,
	             parameters: Parameters = [:],
	             with popover: Popover,
	             completion: CompletionBlock? = nil) {

		let type: ScenePresentationType = popover.insideNavigationBar ? .modalNavigation : .modal

		guard let scene = sceneProvider.scene(with: scene,
		                                      parameters: parameters,
		                                      type: type,
		                                      animated: true) else { return }

		sceneRenderer.popover(popover, to: scene).execute(with: completion)
	}

	func popover(_ scene: SceneName,
	             parameters: Parameters = [:],
	             from button: UIBarButtonItem,
	             completion: CompletionBlock? = nil) {

		guard let scene = sceneProvider.scene(with: scene,
		                                      parameters: parameters,
		                                      type: .modal,
		                                      animated: true) else { return }

		let popover = Popover()
		popover.barButtonItem = button
		sceneRenderer.popover(popover, to: scene).execute(with: completion)
	}

	func popover(_ scene: SceneName,
	             parameters: Parameters = [:],
	             from view: UIView,
	             completion: CompletionBlock? = nil) {

		guard let scene = sceneProvider.scene(with: scene,
		                                      parameters: parameters,
		                                      type: .modal,
		                                      animated: true) else { return }

		let popover = Popover()
		popover.sourceView = view
		popover.sourceRect = view.frame
		sceneRenderer.popover(popover, to: scene).execute(with: completion)
	}
}

// MARK: - View

public extension Navigator {
	func view(for scene: SceneName, parameters: Parameters = [:]) -> UIViewController? {
		guard let scene = sceneProvider.scene(with: scene,
		                                      parameters: parameters,
		                                      type: .modal,
		                                      animated: true) else { return nil }

		return scene.buildViewController()
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

// MARK: - Navigating with Scenes

extension Navigator {
	func urlBuilder(for url: URL) -> (SceneBuilder) -> Void {
		return { builder in
			let scenes = self.sceneURLHandler.scenes(from: url)
			scenes.forEach { builder.appendModal(name: $0) }
		}
	}

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
