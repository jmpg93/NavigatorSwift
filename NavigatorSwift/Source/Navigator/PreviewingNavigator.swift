//
//  PreviewingNavigator.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol PreviewingNavigator: Navigator, UIViewControllerPreviewingDelegate {
	var previewingScene: SceneName? { get set }
	var previewingParametes: Parameters? { get set }
	var previewingCompletion: CompletionBlock? { get set }

	func preview(scene: SceneName, parameters: Parameters, completion: CompletionBlock?)
}

extension PreviewingNavigator {
	func preview(scene: SceneName, parameters: Parameters, completion: CompletionBlock?) {
		self.previewingScene = scene
		self.previewingParametes = parameters
		self.previewingCompletion = completion
	}
}

extension PreviewingNavigator {
	func viewController(for sceneName: SceneName, parameters: Parameters = [:]) -> UIViewController? {
		return sceneProvider
			.scene(with: sceneName, type: .modal)?
			.sceneHandler
			._buildViewController(with: parameters)
	}
}

extension PreviewingNavigator {
	public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                              viewControllerForLocation location: CGPoint) -> UIViewController? {
		guard let scene = previewingScene else { return nil }
		guard let parametes = previewingParametes else { return nil }

		return viewController(for: scene, parameters: parametes)
	}

	public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                              commit viewControllerToCommit: UIViewController) {

		previewingCompletion?()
	}
}
