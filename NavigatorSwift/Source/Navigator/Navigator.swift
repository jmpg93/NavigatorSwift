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
	var sceneURLHandler: SceneURLHandler { get }
}

// MARK: - Set root with Scene names

public extension Navigator {
	func root(_ name: SceneName, parameters: Parameters = [:]) {
		logDebug("Root \(name)")
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .root)
		navigate(with: sceneOperationManager.root(scene: scene))
	}
}

// MARK: - Navigating with Scene names

public extension Navigator {
	func push(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Push \(name)")
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .push, animated: animated)
		navigate(with: sceneOperationManager.add(scenes: [scene]), completion: completion)
	}

	func present(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Present \(name)")
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modal, animated: animated)
		navigate(with: sceneOperationManager.add(scenes: [scene]), completion: completion)
	}

	func presentNavigation(_ name: SceneName, parameters: Parameters = [:], animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Root \(name)")
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modalNavigation, animated: animated)
		navigate(with: sceneOperationManager.add(scenes: [scene]), completion: completion)
	}
}

// MARK: - Poping and Dismissing Scenes

public extension Navigator {
	func pop(animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Pop")
		navigate(with: sceneOperationManager.pop(animated: animated), completion: completion)
	}

	func popToRoot(animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Pop to root")
		navigate(with: sceneOperationManager.popToRoot(animated: animated), completion: completion)
	}

	func dismiss(animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Dismiss first")
		navigate(with: sceneOperationManager.dismiss(animated: animated), completion: completion)
	}

	func dismiss(_ name: SceneName, animated: Bool = true, completion: CompletionBlock? = nil) {
		logDebug("Dismiss scene \(name)")
		navigate(with: sceneOperationManager.dismiss(sceneName: name, animated: animated), completion: completion)
	}

	func dismissAll(animated: Bool, completion: CompletionBlock? = nil) {
		logDebug("Dismiss all")
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
	func build(using builder: SceneBuilderBlock<Self>) {
		build(using: builder, completion: nil)
	}

	func build(using builder: SceneBuilderBlock<Self>, completion: CompletionBlock?) {
		let (scenes, navigateAbsolutly) = sceneProvider.scenes(with: builder)
		
		if navigateAbsolutly {
			logDebug("Build absolutly navigation")
			navigate(with: sceneOperationManager.set(scenes: scenes), completion: completion)
		} else {
			logDebug("Build relative navigation")
			navigate(with: sceneOperationManager.add(scenes: scenes), completion: completion)
		}
	}
}

// MARK: - Deeplink

public extension Navigator {
	func url(_ url: URL, completion: CompletionBlock? = nil) {
		logDebug("URL \(url)")
		let sceneContexts = sceneURLHandler.sceneContexts(from: url)
		build { sceneContexts.forEach($0.add) }
	}
}

// MARK: - Transition

public extension Navigator {
	func transition(to name: SceneName, parameters: Parameters = [:], with transition: Transition, completion: CompletionBlock? = nil) {
		logDebug("Transition \(name)")
		let type: ScenePresentationType = transition.insideNavigationBar ? .modalNavigation : .modal
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: type, animated: true)
		sceneOperationManager.transition(transition, to: scene).execute(with: completion)
	}
}

// MARK: - Popover

public extension Navigator {
	func popover(_ name: SceneName,  parameters: Parameters = [:], with popover: Popover, completion: CompletionBlock? = nil) {
		logDebug("Popover \(name)")
		let type: ScenePresentationType = popover.insideNavigationBar ? .modalNavigation : .modal
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: type, animated: true)
		sceneOperationManager.popover(popover, to: scene).execute(with: completion)
	}

	func popover(_ name: SceneName, parameters: Parameters = [:], from button: UIBarButtonItem, completion: CompletionBlock? = nil) {
		logDebug("Popover \(name) from barButtonItem")
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modal, animated: true)

		let popover = Popover()
		popover.barButtonItem = button

		sceneOperationManager.popover(popover, to: scene).execute(with: completion)
	}

	func popover(_ name: SceneName, parameters: Parameters = [:], from view: UIView, completion: CompletionBlock? = nil) {
		logDebug("Popover \(name) from view")
		let scene = sceneProvider.scene(with: name, parameters: parameters, type: .modal, animated: true)
		let popover = Popover()
		popover.sourceView = view
		popover.sourceRect = view.frame
		sceneOperationManager.popover(popover, to: scene).execute(with: completion)
	}
}

// MARK: - Reload

extension Navigator {
	func reload(_ name: SceneName,  parameters: Parameters = [:], completion: CompletionBlock? = nil) {
		logDebug("Reload \(name)")
		let scene = sceneProvider.scene(with: name, type: .select)
		sceneOperationManager.reload(scene:scene).execute(with: completion)
	}
}

// MARK: - View

public extension Navigator {
	func view(for name: SceneName, parameters: Parameters = [:]) -> UIViewController? {
		logDebug("View \(name)")
		return sceneProvider.scene(with: name, parameters: parameters, type: .root).view()
	}
}

// MARK: - Traverse

public extension Navigator {
	func traverse(block: @escaping TraverseBlock) {
		traverse(block: block, completion: nil)
	}

	func traverse(block: @escaping TraverseBlock, completion: CompletionBlock?) {
		logDebug("Traverse")
		navigate(with: sceneOperationManager.traverse(block: block), completion: completion)
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
