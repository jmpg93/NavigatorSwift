//
//  ScenePresentationState.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 4/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol ScenePresentationState {
	var name: SceneName { get }
	var type: ScenePresentationType { get }
}

// MARK: Extensions

extension Scene: ScenePresentationState {
	public var name: SceneName {
		return sceneHandler.name
	}
}

extension SceneState: ScenePresentationState {

}

// MARK: - Array utils

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
			.first(where: { typesMathes($0.element.type, type) })
			.map({ $0.offset })
	}

	private func typesMathes(_ leftType: ScenePresentationType, _ rightType: ScenePresentationType) -> Bool {
		switch (leftType, rightType) {
		case (.modal, .modal),
			 (.modalNavigation, .modalNavigation),
			 (.modalNavigation, .modal),
			 (.modal, .modalNavigation):
			return true
		default:
			return leftType.rawValue == rightType.rawValue
		}
	}
}
