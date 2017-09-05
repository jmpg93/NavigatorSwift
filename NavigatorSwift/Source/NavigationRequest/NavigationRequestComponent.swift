//
//  NavigationRequestComponent.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class NavigationRequestComponent {
	public let name: SceneName
	public let presentMode: ScenePresentationType
	public let parameters: Parameters
	public let animated: Bool

	public init(name: SceneName,
	            presentMode: ScenePresentationType, 
	            parameters: Parameters,
	            animated: Bool) {
		self.name = name
		self.presentMode = presentMode
		self.parameters = parameters
		self.animated = animated
	}

	public var pathComponent: String {
		var string = ""
		
		// add the scene name
		string += name.value
		// add meta data for the scene
		string += "\(Delimiters.leftMetaDataDelimiter)"
		// presentation Mode
		string += "\(Delimiters.presentAsKey)\(Delimiters.keyValuePairSeparator)\(presentMode.value)"
		string += Delimiters.metadataSeparator
		// aniation
		string += Delimiters.animatedKey
		string += "=\(animated ? Delimiters.animatedTrueValue : Delimiters.animatedFalseValue)"
		// end meta data for the scene
		string += "\(Delimiters.rightMetaDataDelimiter)"

		return string
	}
}
