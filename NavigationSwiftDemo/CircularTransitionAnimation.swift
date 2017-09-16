//
//  CircularTransitionAnimation.swift
//  Tuenti
//
//  Created by jmpuerta on 27/8/17.
//  Copyright © 2017 Tuenti Technologies S.L. All rights reserved.
//

import NavigatorSwift
import Foundation
import UIKit

class CircularTransitionAnimation: UIPercentDrivenInteractiveTransition, Transition {
	var modalPresentationStyle: UIModalPresentationStyle {
		return .custom
	}
}

extension CircularTransitionAnimation: UIViewControllerAnimatedTransitioning {
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let view = transitionContext.view(forKey: .to) else {
			return
		}

		transitionContext.containerView.addSubview(view)

		view.transform = CGAffineTransform(translationX: 600, y: 0)

		UIView.animate(withDuration: 0.4,
		               delay: 0.0,
		               options: [],
		               animations: { view.transform = .identity },
		               completion: { completed in transitionContext.completeTransition(completed) })
	}

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.4
	}
}

