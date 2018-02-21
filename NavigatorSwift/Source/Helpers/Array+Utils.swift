//
//  Array+Utils.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 6/12/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

// MARK: Hashable

extension Array where Element: Hashable {
	func after(item: Element) -> Element? {
		if let index = self.index(of: item), index + 1 < self.count {
			return self[index + 1]
		}
		return nil
	}
}

// MARK: SceneOperationInterceptor

public extension Array where Element == SceneOperationInterceptor {
	func first(for operation: SceneOperation, with context: SceneOperationContext) -> Element? {
		return first(where: { $0.shouldIntercept(operation, with: context) })
	}
}


// MARK: ScenePresentationState

public extension Array where Element: ScenePresentationState {
	func dropping(from type: ScenePresentationType) -> [ScenePresentationState] {
		if let index = index(of: type) {
			return Array(self[0..<index])
		} else {
			return self
		}
	}

	func dropping(first type: ScenePresentationType) -> [ScenePresentationState] {
		if let last = last, type == last.type {
			return Array(dropLast())
		} else {
			return self
		}
	}

	func appending(_ state: ScenePresentationState) -> [ScenePresentationState] {
		return appending([state])
	}

	func appending(_ states: [ScenePresentationState]) -> [ScenePresentationState] {
		return self + states
	}

	private func index(of type: ScenePresentationType) -> Index? {
		return lazy
			.enumerated()
			.first(where: { typesMatches($0.element.type, type) })
			.map({ $0.offset })
	}

	private func typesMatches(_ leftType: ScenePresentationType, _ rightType: ScenePresentationType) -> Bool {
		switch (leftType, rightType) {
		case (.modalNavigation, .modal),
			 (.modal, .modalNavigation):
			return true
		default:
			return leftType.rawValue == rightType.rawValue
		}
	}
}

// MARK: ScenePresentationState

public extension Array where Element == ScenePresentationState {
	var names: [SceneName] {
		return map({ $0.name })
	}

	var types: [ScenePresentationType] {
		return map({ $0.type })
	}
}
