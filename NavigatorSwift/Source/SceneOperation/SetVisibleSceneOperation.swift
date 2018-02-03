//
//  RemoveFromSceneOperation.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 6/12/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

struct SetVisibleSceneOperation {
	private let viewController: UIViewController
	private let manager: SceneOperationManager

	init(viewController: UIViewController, manager: SceneOperationManager) {
		self.viewController = viewController
		self.manager = manager
	}
}

// MARK: SceneOperation methods

extension SetVisibleSceneOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		logTrace("[SetVisibleSceneOperation] Executing operation")

		let group = DispatchGroup()

		if let presentingViewController = viewController.presentedViewController?.presentingViewController {
			group.enter()
			presentingViewController.dismiss(animated: true, completion: group.leave)
		}

		if let navigationController = viewController.navigationController {
			group.enter()
			CATransaction.begin()
			navigationController.popToViewController(viewController, animated: true)
			CATransaction.setCompletionBlock(group.leave)
			CATransaction.commit()
		}

		DispatchQueue.global().async {
			group.wait()
			DispatchQueue.main.async { completion?() }
		}
	}
}


