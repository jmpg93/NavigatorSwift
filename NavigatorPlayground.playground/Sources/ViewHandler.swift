import Foundation

public protocol ViewHandler {
	var viewName: ViewName { get }
	func view() -> View
}
