//
//  UIViewController+Utils.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	private enum AssociatedKeys {
		static var sceneNameKey = "ns_SceneNameKey"
	}

	var sceneName: String? {
		get {
			return objc_getAssociatedObject(self, &AssociatedKeys.sceneNameKey) as? String
		}

		set {
			objc_setAssociatedObject(self, &AssociatedKeys.sceneNameKey, newValue as NSString?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	/// Returnsthe ScenePresentationType based on his current hierarchy.
	var scenePresentationType: ScenePresentationType {
		if self is ViewControllerContainer {
			return .root
		} else if navigationController != nil && navigationController?.presentingViewController != nil {
			return .modalNavigation
		} else if presentingViewController != nil && navigationController == nil {
			return .modal
		} else if navigationController != nil {
			return .push
		} else {
			return .none
		}
	}

	/// Returns true if the viewController presented as require the ScenePresentationType (by checking the hierarchy of the viewController), false otherwise.
	func isPresentedAsRequire(for type: ScenePresentationType) -> Bool {
		switch (type, scenePresentationType) {
		case (.push, .push),
			 (.modal, .modal),
			 (.modalNavigation, .modalNavigation),
			 (.root, .root),
			 (_, .none),
			 (.none, _):
			return true
		default:
			return false
		}
	}

	/// Returns true if the viewController can be handled by the scene and also is presented as require the scene, false otherwise.
	func isRecyclable(by scene: Scene) -> Bool {
		let isManagedByScene = scene.sceneHandler.name.value == sceneName
		let isReloadable = scene.sceneHandler.isReloadable
		let isPresentedAsRequireScene = isPresentedAsRequire(for: scene.type)

		return isManagedByScene && isPresentedAsRequireScene && isReloadable
	}
}

extension UIView {
	static let defaultAnimationDuration: TimeInterval = 0.35
}

extension UIViewController {
	var isBeingDisplayedModally: Bool {
		let presentedModally = presentingViewController?.presentedViewController == self
		let ancestorNavigationControllerPresentedModally = navigationController != nil && navigationController?.presentingViewController?.presentedViewController == navigationController
		let ancestorTabBarControllerPresentedModally = tabBarController?.presentingViewController is UITabBarController

		return presentedModally
			|| ancestorNavigationControllerPresentedModally
			|| ancestorTabBarControllerPresentedModally
	}
}
