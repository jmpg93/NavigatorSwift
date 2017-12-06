//
//  MockWindow.swift
//  NavigatorSwiftTests
//
//  Created by jmpuerta on 6/12/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class MockWindow: UIWindow {
	var madeKeyAndVisible = false
	override open func makeKeyAndVisible() {
		madeKeyAndVisible = true
	}
}
