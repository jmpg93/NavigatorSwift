import Foundation

public class Navigator {
	private let handlerContainer = ViewHandlerContainer.shared

	public init() { }

	public func register(handler: ViewHandler) {
		handlerContainer.register(handler: handler)
	}

	public func push(view: ViewName, transition: Transition) {
		guard let view = handlerContainer.view(for: view) else {
			return
		}

		view.apply(transition: transition)
	}

	public func push(view: ViewName) {

	}
}
