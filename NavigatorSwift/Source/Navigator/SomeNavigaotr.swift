//
//  SomeNavigaotr.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 11/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class Presenter: NavigatorExtensionsProvider {
	func navigateToSomeView()
}

extension Nav where Base: SomeNavigator {
	func navigateToSomeView() {

	}
}
