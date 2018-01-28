//
//  SceneName.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public struct SceneName {
	public let value: String

	public init(_ value: String) {
		self.value = value
	}
}

extension SceneName: Hashable {
	public static func == (lhs: SceneName, rhs: SceneName) -> Bool {
		return lhs.value == rhs.value
	}

	public var hashValue: Int {
		return value.hashValue
	}
}

extension SceneName: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self.value = value
	}

	public init(unicodeScalarLiteral value: String) {
		self.init(stringLiteral: value)
	}

	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(stringLiteral: value)
	}
}

extension SceneName: CustomStringConvertible {
	public var description: String {
		return value
	}
}
