//
//  ScenePresentationType.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public enum ScenePresentationType: Int {
	case push = 0
	case modal
	case modalInsideNavigationBar

	public var value: String {
		switch self {
		case .modal:
			return Delimiters.presenteAsModalValue
		case .push:
			return Delimiters.presentAsPushValue
		case .modalInsideNavigationBar:
			return Delimiters.presentAsModalWithNavigationControllerValue
		}
	}
}
