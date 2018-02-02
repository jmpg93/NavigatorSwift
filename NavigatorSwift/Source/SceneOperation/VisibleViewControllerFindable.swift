//
//  VisibleViewControllerFinder.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

protocol VisibleViewControllerFindable: NextViewControllerFindable {
	func visible(from fromViewController: UIViewController) -> UIViewController
}

extension VisibleViewControllerFindable {
	func visible(from fromViewController: UIViewController) -> UIViewController {
		var _next = fromViewController

		while let next = next(before: _next) {
			_next = next
		}

		return _next
	}
}
