//
//  MockViewController.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 20/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class MockViewController: UIViewController {
	var dismissed = false
	var _isBeingDisplayedModally = false

	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		dismissed = true
	}

	var isBeingDisplayedModally: Bool {
		return _isBeingDisplayedModally
	}
}
