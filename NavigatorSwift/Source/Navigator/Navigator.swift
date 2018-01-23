//
//  Navigator.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol Navigator: class {
	var sceneProvider: SceneProvider { get }
	var sceneOperationManager: SceneOperationManager { get }
	var sceneURLHandler: SceneURLHandler { get set }
}

// MARK: - Set root with Scene names

public extension Navigator {
	func root(_ scene: SceneName, parameters: Parameters = [:]) {
		let scene = sceneProvider.scene(with: scene, parameters: parameters, type: .root)
		navigate(with: sceneOperationManager.root(scene: scene))
	}
}

// MARK: - Navigating with Scene names

public extension Navigator {
	func push(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .push, animated: animated)
		navigate(with: sceneOperationManager.add(scenes: [scene]), completion: completion)
	}

	func present(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modal, animated: animated)
		navigate(with: sceneOperationManager.add(scenes: [scene]), completion: completion)
	}

	func presentNavigation(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modalNavigation, animated: animated)
		navigate(with: sceneOperationManager.add(scenes: [scene]), completion: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

public extension Navigator {
	func pop(animated: Bool = true, completion: CompletionBlock? = nil) {
		navigate(with: sceneOperationManager.pop(animated: animated), completion: completion)
	}

	func popToRoot(animated: Bool = true, completion: CompletionBlock? = nil) {
		navigate(with: sceneOperationManager.popToRoot(animated: animated), completion: completion)
	}

	func dismiss(animated: Bool = true, completion: CompletionBlock? = nil) {
		navigate(with: sceneOperationManager.dismiss(animated: animated), completion: completion)
	}

	func dismiss(_ sceneName: SceneName, animated: Bool = true, completion: CompletionBlock? = nil) {
		navigate(with: sceneOperationManager.dismiss(sceneName: sceneName, animated: animated), completion: completion)
	}

	func dismissAll(animated: Bool, completion: CompletionBlock? = nil) {
		navigate(with: sceneOperationManager.dismissAll(animated: animated), completion: completion)
	}
}

// MARK: - Navigate with operation

public extension Navigator {
	func navigate(with operation: SceneOperation, completion: CompletionBlock? = nil) {
		operation.execute(with: completion)
	}
}

// MARK: - Navigate with builder

public extension Navigator {
	func build(using builder: (SceneBuilder) -> Void) {
		build(using: builder, completion: nil)
	}

	func build(using builder: (SceneBuilder) -> Void, completion: CompletionBlock?) {
		let (scenes, navigateAbsolutly) = sceneProvider.scenes(with: builder)
		
		if navigateAbsolutly {
			navigate(with: sceneOperationManager.set(scenes: scenes), completion: completion)
		} else {
			navigate(with: sceneOperationManager.add(scenes: scenes), completion: completion)
		}
	}
}

// MARK: - Deeplink

public extension Navigator {
	func url(_ url: URL, completion: CompletionBlock? = nil) {
		let builder = urlBuilder(for: url)
		build(using: builder, completion: completion)
	}
}

// MARK: - Transition

public extension Navigator {
	func transition(to scene: SceneName, parameters: Parameters = [:], with transition: Transition, completion: CompletionBlock? = nil) {
		let type: ScenePresentationType = transition.insideNavigationBar ? .modalNavigation : .modal
		let scene = sceneProvider.scene(with: scene, parameters: parameters, type: type, animated: true)

		sceneOperationManager.transition(transition, to: scene).execute(with: completion)
	}
}

// MARK: - Popover

public extension Navigator {
	func popover(_ scene: SceneName,  parameters: Parameters = [:], with popover: Popover, completion: CompletionBlock? = nil) {
		let type: ScenePresentationType = popover.insideNavigationBar ? .modalNavigation : .modal
		let scene = sceneProvider.scene(with: scene, parameters: parameters, type: type, animated: true)

		sceneOperationManager.popover(popover, to: scene).execute(with: completion)
	}

	func popover(_ scene: SceneName, parameters: Parameters = [:], from button: UIBarButtonItem, completion: CompletionBlock? = nil) {
		let scene = sceneProvider.scene(with: scene, parameters: parameters, type: .modal, animated: true)

		let popover = Popover()
		popover.barButtonItem = button

		sceneOperationManager.popover(popover, to: scene).execute(with: completion)
	}

	func popover(_ scene: SceneName, parameters: Parameters = [:], from view: UIView, completion: CompletionBlock? = nil) {
		let scene = sceneProvider.scene(with: scene, parameters: parameters, type: .modal, animated: true)

		let popover = Popover()
		popover.sourceView = view
		popover.sourceRect = view.frame
		sceneOperationManager.popover(popover, to: scene).execute(with: completion)
	}
}

// MARK: - Reload

extension Navigator {
	func reload(_ name: SceneName,  parameters: Parameters = [:], completion: CompletionBlock? = nil) {
		let scene = sceneProvider.scene(with: name, type: .reload)
		sceneOperationManager.reload(scene:scene).execute(with: completion)
	}
}

// MARK: - View

public extension Navigator {
	func view(for scene: SceneName, parameters: Parameters = [:]) -> UIViewController? {
		return sceneProvider.scene(with: scene, parameters: parameters, type: .root).view()
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

private extension Navigator {
	func urlBuilder(for url: URL) -> (SceneBuilder) -> Void {
		return { builder in
			//TODO: Upgrade this
			let scenes = self.sceneURLHandler.scenes(from: url)
			scenes.forEach { builder.present($0) }
		}
	}
}
