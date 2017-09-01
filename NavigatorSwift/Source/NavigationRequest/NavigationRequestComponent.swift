//
//  NavigationRequestComponent.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class NavigationRequestComponent {
	let name: String
	let presentMode: ScenePresentationType
	let parameters: Parameters
	let animated: Bool

	init(name: String, presentMode: ScenePresentationType, parameters: Parameters, animated: Bool) {
		self.name = name
		self.presentMode = presentMode
		self.parameters = parameters
		self.animated = animated
	}

	var pathComponent: String {
		//TODO: Do
		return ""
	}
}
