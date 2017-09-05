//
//  NavigationRequest.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class NavigationRequest: NavigationRequestBuilder {
	fileprivate var components: [NavigationRequestComponent] = []

	public init(using builderBlock: NavigationRequestBuilderBlock) {
		builderBlock(self)
	}

	public init(components: [NavigationRequestComponent]) {
		self.components = components
	}
}

// MARK: - Public implementation

public extension NavigationRequest {
	var url: URL {

		let urlString = components.map { "/" + $0.pathComponent }.reduce("") { $0 + $1 } + "/"
		let urlStringScaped = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

		return URL(string: urlStringScaped)!
	}

	var allParameters: Parameters {
		var allParameters: Parameters = [:]

		for component in components {
			allParameters[component.name] = component.parameters
		}

		return allParameters
	}
}

// MARK: - NavigationRequestBuilder Protocol

public extension NavigationRequest {
	func appendPushScene(withName name: SceneName) {
		appendPushScene(withName: name,
		                parameters: [:],
		                animated: true)
	}

	func appendPushScene(withName name: SceneName, parameters: Parameters, animated: Bool) {
		let component = NavigationRequestComponent(name: name,
		                                           presentMode: .push,
		                                           parameters: parameters,
		                                           animated: animated)
		components.append(component)
	}

	func appendModalScene(withName name: SceneName) {
		appendModalScene(withName: name,
		                 parameters: [:],
		                 animated: true)
	}

	func appendModalScene(withName name: SceneName, parameters: Parameters, animated: Bool) {
		let component = NavigationRequestComponent(name: name,
		                                           presentMode: .modal,
		                                           parameters: parameters,
		                                           animated: animated)
		components.append(component)
	}

	func appendModalWithNavigationScene(withName name: SceneName) {
		appendModalWithNavigationScene(withName: name,
		                               parameters: [:],
		                               animated: true)
	}

	func appendModalWithNavigationScene(withName name: SceneName, parameters: Parameters, animated: Bool) {
		let component = NavigationRequestComponent(name: name,
		                                           presentMode: .modalInsideNavigationBar,
		                                           parameters: parameters,
		                                           animated: animated)
		components.append(component)
	}
}
