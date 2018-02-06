//
//  ScenePresentationState+Utils.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 6/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

// MARK: Scene

extension Scene: ScenePresentationState {
	public var name: SceneName {
		return sceneHandler.name
	}
}

// MARK: SceneState

extension SceneState: ScenePresentationState {

}
