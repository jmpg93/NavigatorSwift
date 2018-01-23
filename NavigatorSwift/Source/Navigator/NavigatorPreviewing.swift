//
//  NavigatorPreviewing.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 13/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol NavigatorPreviewing: class {
	var previews: [UIView: (Preview, UIViewControllerPreviewing)] { get set }
}

public extension NavigatorPreviewing where Self: Navigator {
	func preview(_ scene: SceneName, from fromViewController: UIViewController, at sourceView: UIView, parameters: Parameters = [:]) {
		guard fromViewController.traitCollection.forceTouchCapability == .available else { return }
		
		let scene = sceneProvider.scene(with: scene, parameters: parameters, type: .push)
		let preview = Preview(scene: scene, fromViewController: fromViewController)
		let viewControllerPreviewing = fromViewController.registerForPreviewing(with: preview, sourceView: sourceView)
		previews[sourceView] = (preview, viewControllerPreviewing)
	}

	func removePreview(at sourceView: UIView) {
		guard let (preview, viewControllerPreviewing) = previews[sourceView] else { return }
		preview.fromViewController.unregisterForPreviewing(withContext: viewControllerPreviewing)
	}
}
