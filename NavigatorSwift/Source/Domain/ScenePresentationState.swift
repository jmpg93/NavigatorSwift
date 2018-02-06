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
