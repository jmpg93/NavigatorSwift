//
//  Scene.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class Scene {
	let sceneHandler: SceneHandler //TODO: Unowned
	let parameters: Parameters
	let type: ScenePresentationType
	let isAnimated: Bool

	var transition: Transition? = nil
	
	init(sceneHandler: SceneHandler,
	     parameters: Parameters,
	     type typePresentation: ScenePresentationType,
	     animated isAnimated: Bool) {
		self.parameters = parameters
		self.isAnimated = isAnimated
		self.sceneHandler = sceneHandler
		self.type = typePresentation
	}

	func buildViewController() -> UIViewController {
		let viewController = sceneHandler.buildViewController(with: parameters)
		viewController.sceneName = sceneHandler.name.value

		if let transition = transition {
			viewController.modalPresentationStyle = transition.modalPresentationStyle
			viewController.transitioningDelegate = transition
		}

		return viewController
	}
}
