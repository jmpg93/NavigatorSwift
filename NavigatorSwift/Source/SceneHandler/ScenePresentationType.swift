//
//  ScenePresentationType.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public enum ScenePresentationType: String {
	case root
	case push
	case modal
	case modalNavigation
	case select
}

extension ScenePresentationType: Hashable {
	public static func ==(lhs: ScenePresentationType, rhs: ScenePresentationType) -> Bool {
		return lhs.rawValue == rhs.rawValue
	}

	public var hashValue: Int {
		return rawValue.hashValue
	}
}
