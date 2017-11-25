//
//  AppDelegate.swift
//  NavigationSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit
import NavigatorSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	fileprivate enum Constants {
		static let uiTesting = "UITests"
	}

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		setUpWindow()
		setUpUITesting()
		setUpNavigator()

		return true
	}
}

// MARK: Set up

private extension AppDelegate {
	func setUpWindow() {
		window = globalWindow
		window?.makeKeyAndVisible()
	}

	func setUpUITesting() {
		if ProcessInfo.processInfo.arguments.contains(Constants.uiTesting) {
			UIApplication.shared.keyWindow?.layer.speed = 100
		}
	}

	func setUpNavigator() {
		let collection = CollectionScenHandler()
		globalNavigator.register(collection)
		globalNavigator.root(.collection)
	}
}
