//
//  Nav.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 11/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol NavigatorExtensionsProvider: class {}

extension NavigatorExtensionsProvider {
	public var navigator: Nav<Self> {
		return Nav(self)
	}

	public static var navigator: Nav<Self>.Type {
		return Nav<Self>.self
	}
}

public struct Nav<Base> {
	public let base: Base

	fileprivate init(_ base: Base) {
		self.base = base
	}
}

