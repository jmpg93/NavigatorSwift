//
//  NavigatorPreviewing.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 13/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol NavigatorPreviewing: class {
	var previews: [UIView: Preview] { get set }
}

public extension NavigatorPreviewing where Self: Navigator {
	func registerPreview(_ scene: SceneName,
						 type: ScenePresentationType,
						 from fromViewController: UIViewController,
						 sourceView: UIView,
						 parameters: Parameters = [:]) {
		guard fromViewController.traitCollection.forceTouchCapability == .available else { return }

		let scene = provider.scene(with: scene, parameters: parameters, type: type)
		let preview = Preview(scene: scene, fromViewController: fromViewController)

		// HACK
		// If there is peek in progress and the scenes match, update the current preview.
		// This will prevent a double registration and the dealloc of the current viewControllerPreviewing
		// (which will provoke the peek to fail)
		if let currentPreview = previews[sourceView], currentPreview.isPeeking {
			currentPreview.update(with: preview)
		} else {
			preview.unregister(from: sourceView)
			preview.register(from: sourceView)
			previews[sourceView] = preview
		}
	}

	func registerPreview(_ scene: SceneName,
						 type: ScenePresentationType,
						 from sceneName: SceneName,
						 sourceView: UIView,
						 parameters: Parameters = [:]) {
		guard let matchingViewController = firstViewController(matching: sceneName) else { return }

		registerPreview(scene,
						type: type,
						from: matchingViewController,
						sourceView: sourceView,
						parameters: parameters)
	}

	func unregisterPreview(sourceView: UIView) {
		guard let preview = previews[sourceView] else { return }
		guard !preview.isPeeking else { return }

		preview.unregister(from: sourceView)
		previews.removeValue(forKey: sourceView)
	}
}

private extension NavigatorPreviewing where Self: Navigator  {
	func firstViewController(matching sceneName: SceneName) -> UIViewController? {
		return manager.firstViewController(matching: sceneName, from: manager.rootViewController)
	}
}
