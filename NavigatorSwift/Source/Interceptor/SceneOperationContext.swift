//
//  SceneOperationContext.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public struct SceneOperationContext {
	public static let empty = SceneOperationContext(from: [], to: [])
	
	public let from: [ScenePresentationState]
	public let to: [ScenePresentationState]
}
