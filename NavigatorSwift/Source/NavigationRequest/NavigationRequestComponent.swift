//
//  NavigationRequestComponent.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class NavigationRequestComponent {
	public let name: String
	public let presentMode: ScenePresentationType
	public let parameters: Parameters
	public let animated: Bool

	public init(name: String, presentMode: ScenePresentationType, parameters: Parameters, animated: Bool) {
		self.name = name
		self.presentMode = presentMode
		self.parameters = parameters
		self.animated = animated
	}

	public var pathComponent: String {
		//TODO: Do
		return ""
	}
}
