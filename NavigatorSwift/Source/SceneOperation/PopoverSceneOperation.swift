//
//  PopOverSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 20/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class PopoverSceneOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let popover: Popover
	fileprivate let scene: Scene
	fileprivate let renderer: SceneRenderer

	init(popover: Popover, to scene: Scene, renderer: SceneRenderer) {
		self.popover = popover
		self.scene = scene
		self.renderer = renderer
	}
}

extension PopoverSceneOperation {
	func execute(with completion: CompletionBlock?) {
		scene.operationParameters[ParametersKeys.popover] = popover
		renderer.add(scenes: [scene]).execute(with: completion)
	}
}
