//
//  Preview.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class Preview: NSObject {
	fileprivate let handler: SceneHandler
	fileprivate let parametes: Parameters
	fileprivate let completion: CompletionBlock?
	let fromViewController: UIViewController

	init(handler: SceneHandler,
	     parametes: Parameters = [:],
	     fromViewController: UIViewController,
	     completion: CompletionBlock? = nil) {
		self.handler = handler
		self.parametes = parametes
		self.completion = completion
		self.fromViewController = fromViewController
	}
}

extension Preview: UIViewControllerPreviewingDelegate {
	public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                       viewControllerForLocation location: CGPoint) -> UIViewController? {
		return handler._buildViewController(with: parametes)
	}

	public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                       commit viewControllerToCommit: UIViewController) {
		fromViewController.show(viewControllerToCommit, sender: nil)
	}
}
