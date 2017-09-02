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
			if let newValue = newValue {
				objc_setAssociatedObject(
					self,
					&AssociatedKeys.sceneNameKey,
					newValue as NSString?,
					.OBJC_ASSOCIATION_RETAIN_NONATOMIC
				)
			}
		}
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

		return presentedModally || ancestorNavigationControllerPresentedModally || ancestorTabBarControllerPresentedModally
	}
}
