//
//  PopOverSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 20/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct PopoverSceneOperation: VisibleViewControllerFindable {
	fileprivate let popover: Popover
	fileprivate let scene: Scene
	fileprivate let manager: SceneOperationManager

	init(popover: Popover, to scene: Scene, manager: SceneOperationManager) {
		self.popover = popover
		self.scene = scene
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension PopoverSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[PopSceneOperation] Executing operation")
		scene.operationParameters[ParametersKeys.popover] = popover
		manager.add(scenes: [scene]).execute(with: completion)
	}
}
