import Foundation

public struct ViewName {
	public let name: String
	
	public init(_ name: String) {
		self.name = name
	}
}

extension ViewName: Hashable {
	public var hashValue: Int {
		return name.hashValue
	}

	public static func == (lhs: ViewName, rhs: ViewName) -> Bool {
		return lhs.name == rhs.name
	}
}
