//
//  ViewController.swift
//  NavigationSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit
import NavigatorSwift

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func push(_ sender: UIButton) {
		let nav = navigator(for: view.window!)
		let requestProvider = DefaultNavigationRequestProvider()
		let request = requestProvider.navigationRequest { builder in
			builder.appendPushScene(withName: "Login")
			builder.appendPushScene(withName: "Login")
			builder.appendPushScene(withName: "Login")
		}

		nav.navigateToScene(withAbsoluteURL: request.url, parameters: [:])
	}
}

