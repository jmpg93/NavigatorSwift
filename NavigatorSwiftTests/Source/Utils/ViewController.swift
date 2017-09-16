//
//  ViewController.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

open class ViewController: UIViewController {
	open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		super.dismiss(animated: flag, completion: completion)
	}
}

open class Window: UIWindow {
	var didCallMakeKeyAndVisible: Bool = false

	override open func makeKeyAndVisible() {
		didCallMakeKeyAndVisible = true
	}
}
