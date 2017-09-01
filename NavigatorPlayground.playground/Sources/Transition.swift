import Foundation
import UIKit

public struct Transition {
	public let mode: UIModalPresentationStyle
	public let animator: UIViewControllerAnimatedTransitioning
	public let delegate: UIViewControllerTransitioningDelegate

	public init(mode: UIModalPresentationStyle,
	            animator: UIViewControllerAnimatedTransitioning,
	            delegate: UIViewControllerTransitioningDelegate) {
		self.mode = mode
		self.animator = animator
		self.delegate = delegate
	}
}
