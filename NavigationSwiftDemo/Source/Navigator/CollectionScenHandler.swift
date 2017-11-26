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
	static let collection: SceneName = "Collection"
}

class CollectionScenHandler: SceneHandler {
	enum Parameter {
		static let stateLabel = "stateLabel"
	}
	
	func buildViewController(with parameters: Parameters) -> UIViewController {
		let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Collection") as! Collection
		if let state = parameters[Parameter.stateLabel] as? String {
			view.stateText = state
		}
		return view
	}

	var name: SceneName {
		return .collection
	}

	func reload(_ viewController: UIViewController, parameters: Parameters) {
		print("Reloaded")
	}

	var isViewControllerRecyclable: Bool {
		return true
	}
}
