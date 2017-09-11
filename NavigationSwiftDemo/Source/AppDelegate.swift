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
	var window: UIWindow?

	func application(_ application: UIApplication,
	                 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		window = globalWindow
		window?.makeKeyAndVisible()

		let requestProvider = DefaultNavigationRequestProvider()
		let request = requestProvider.navigationRequest { builder in
			builder.appendPushScene(withName: .collection)
		}

		globalNavigator.absoluteNavigation(using: request)
		
		return true
	}
}
