//
//  LeftTransition.swift
//  Tuenti
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import NavigatorSwift
import Foundation
import UIKit

class LeftTransition: UIPercentDrivenInteractiveTransition, Transition {
	var insideNavigationBar: Bool {
		return true
	}

	var modalPresentationStyle: UIModalPresentationStyle {
		return .custom
	}
}

extension LeftTransition: UIViewControllerAnimatedTransitioning {
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let view = transitionContext.view(forKey: .to) else {
			return
		}

		transitionContext.containerView.addSubview(view)

		view.transform = CGAffineTransform(translationX: -600, y: 0)

		UIView.animate(withDuration: 0.6,
		               delay: 0.0,
		               usingSpringWithDamping: 0.8,
		               initialSpringVelocity: 0.3,
		               options: [],
		               animations: { view.transform = .identity },
		               completion: { _ in transitionContext.completeTransition(!transitionContext.transitionWasCancelled) })
	}

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.6
	}
}

extension LeftTransition {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}
}

