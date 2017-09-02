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
	public static func ==(lhs: SceneName, rhs: SceneName) -> Bool {
		return lhs.value == rhs.value
	}

	public var hashValue: Int {
		return value.hashValue
	}
}

extension SceneName: ExpressibleByStringLiteral {
	public typealias StringLiteralType = String

	public init(stringLiteral value: String) {
		self = SceneName(value)
	}
}
