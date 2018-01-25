//
//  AppDelegate.swift
//  NavigatorSwiftDemo
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
		globalNavigator.register([CollectionSceneHandler(), BlueSceneHandler(), RedSceneHandler(), TabBarSceneHandler()])
		globalNavigator.root(.tabBar)
		globalNavigator.setTabs([.blue, .red, .collection])

		navigate(afer: 2)
		navigate(afer: 4)
	}
}

// MARK: Private methods

private extension AppDelegate {
	func navigate(afer: TimeInterval) {
		DispatchQueue.global().asyncAfter(deadline: .now() + afer) {
			DispatchQueue.main.async {
				globalNavigator.build { builder in
					builder.root(.tabBar)
					builder.tab(.red)
					builder.presentNavigation(.blue)
					builder.push(.collection)
				}
			}
		}
	}
}

private extension SceneContext {
	static let blue = SceneContext(sceneName: .blue)
	static let red = SceneContext(sceneName: .red)
	static let collection = SceneContext(sceneName: .collection)
}
