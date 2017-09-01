import Foundation

public class ViewHandlerContainer {
	public static let shared = ViewHandlerContainer()

	private var handlers: [ViewName: ViewHandler] = [:]

	public func register(handler: ViewHandler) {
		handlers[handler.viewName] = handler
	}

	public func view(for viewName: ViewName) -> View? {
		guard let index = handlers.index(forKey: viewName) else {
			return nil
		}

		return handlers[index].value.view()
	}
}
