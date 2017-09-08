//
//  AddSceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class AddScenesOperation: SceneOperation, VisibleViewControllerFindable {
	fileprivate let rootViewController: UIViewController
	fileprivate let scenes: [Scene]

	init(scenes: [Scene], rootViewController: UIViewController) {
		self.scenes = scenes
		self.rootViewController = rootViewController
	}
}

// MARK: SceneOperation methods 

extension AddScenesOperation {
	func execute(with completion: CompletionBlock?) {
		guard !scenes.isEmpty else { return }
		
		let visibleViewController = self.visibleViewController(from: rootViewController)
		RenderSceneOperation(scenes: scenes, visibleViewController: visibleViewController).execute(with: completion)
	}
}
