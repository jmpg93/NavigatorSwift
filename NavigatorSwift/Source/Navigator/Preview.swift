//
//  Preview.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class Preview: NSObject {
	fileprivate let scene: Scene
	fileprivate let completion: CompletionBlock?
	let fromViewController: UIViewController

	init(scene: Scene,
	     fromViewController: UIViewController,
	     completion: CompletionBlock? = nil) {
		self.scene = scene
		self.completion = completion
		self.fromViewController = fromViewController
	}
}

extension Preview: UIViewControllerPreviewingDelegate {
	public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                       viewControllerForLocation location: CGPoint) -> UIViewController? {
		return scene.buildViewController()
	}

	public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                       commit viewControllerToCommit: UIViewController) {
		fromViewController.show(viewControllerToCommit, sender: nil)
	}
}
