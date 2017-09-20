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

	var operationParameters: Parameters = [:]
	
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
		configure(viewController)

		return viewController
	}

	func configure(_ viewController: UIViewController) {
		viewController.sceneName = sceneHandler.name.value

		if let transition = operationParameters[ParametersKeys.transition] as? Transition {
			apply(transition, to: viewController)
		}

		if let popover = operationParameters[ParametersKeys.popover] as? Popover {
			apply(popover, to: viewController)
		}
	}
}

extension Scene {
	func apply(_ transition: Transition, to viewController: UIViewController) {
		viewController.modalPresentationStyle = transition.modalPresentationStyle
		viewController.transitioningDelegate = transition
	}

	func apply(_ popover: Popover, to viewController: UIViewController) {
		viewController.modalPresentationStyle = .popover
		viewController.popoverPresentationController?.delegate = popover.delegate
		viewController.popoverPresentationController!.sourceRect = popover.sourceView!.bounds
		viewController.popoverPresentationController!.sourceView = popover.sourceView
		viewController.popoverPresentationController?.barButtonItem = popover.barButtonItem
		viewController.popoverPresentationController?.canOverlapSourceViewRect = popover.canOverlapSourceViewRect
		viewController.popoverPresentationController?.permittedArrowDirections = popover.permittedArrowDirections
		viewController.preferredContentSize = popover.preferredContentSize
	}
}
