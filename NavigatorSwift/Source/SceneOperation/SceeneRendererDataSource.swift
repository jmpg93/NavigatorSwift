//
//  SceneOperationDataSource.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 9/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol SceeneRendererDataSource {
	func install(scene: Scene) -> SceneOperation
	func add(scenes: [Scene]) -> SceneOperation
	func set(scenes: [Scene]) -> SceneOperation
	func dismiss(scene: Scene, animated: Bool) -> SceneOperation
	func dismissFirst(animated: Bool) -> SceneOperation
	func dismissAll(animated: Bool) -> SceneOperation
	func popToRoot(animated: Bool) -> SceneOperation
	func pop(animated: Bool) -> SceneOperation
	func recycle(scenes: [Scene]) -> SceneOperation
	func transition(delegate: UIViewControllerTransitioningDelegate, toViewController: UIViewController) -> SceneOperation
}
