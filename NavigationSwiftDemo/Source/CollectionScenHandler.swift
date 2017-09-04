//
//  CollectionScenHandler.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import NavigatorSwift
import UIKit

extension SceneName {
	static let collection: SceneName = SceneName("Collection")
}

class CollectionScenHandler: SceneHandler {
	var name: SceneName {
		return .collection
	}

	func buildViewController(with parameters: Parameters) -> UIViewController {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
	}
}

class CollectionSceneRegisterer: SceneHandlerRegistrable {
	let sceneHandler = CollectionScenHandler()

	func sceneHandlersToRegister() -> [SceneHandler] {
		return [sceneHandler]
	}
}
