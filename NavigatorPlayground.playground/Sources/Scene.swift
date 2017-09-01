import Foundation

public class Scene {
	public let targetView: View
	public let transition: Transition

	public init(targetView: View, transition: Transition) {
		self.targetView = targetView
		self.transition = transition
	}
}
