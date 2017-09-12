//
//  Preview.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 12/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class Preview: NSObject {
	fileprivate let handler: SceneHandler
	fileprivate let parametes: Parameters
	fileprivate let completion: CompletionBlock?

	init(handler: SceneHandler, parametes: Parameters = [:], completion: CompletionBlock? = nil) {
		self.handler = handler
		self.parametes = parametes
		self.completion = completion
	}
}

extension Preview: UIViewControllerPreviewingDelegate {
	func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                       viewControllerForLocation location: CGPoint) -> UIViewController? {
		return handler._buildViewController(with: parametes)
	}

	func previewingContext(_ previewingContext: UIViewControllerPreviewing,
	                       commit viewControllerToCommit: UIViewController) {
		completion?()
	}
}
