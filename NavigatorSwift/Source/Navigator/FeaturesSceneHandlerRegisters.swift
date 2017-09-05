//
//  FeaturesSceneHandlerRegisters.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol SceneHandlerRegisters {
	var sceneHandlerRegisters: [SceneHandlerRegistrable] { get }
}

public class FeaturesSceneHandlerRegisters: SceneHandlerRegisters {
	public let sceneHandlerRegisters: [SceneHandlerRegistrable]

	public init(sceneHandlerRegisters: [SceneHandlerRegistrable]) {
		self.sceneHandlerRegisters = sceneHandlerRegisters
	}
}
