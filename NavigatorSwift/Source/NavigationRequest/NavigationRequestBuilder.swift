//
//  NavigationRequestBuilder.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol NavigationRequestBuilder {

	/// Append a scene with a push animation.
	///
	/// - parameter: name The name of the scene for append.
	func appendPushScene(withName name: SceneName)


	/// Append a scene with a push animation.
	///
	/// - parameter: name The name of the scene for append.
	/// - parameter: parameters The parameters that are sent to the scene
	/// - parameter: animated Pass YES to animate the presentation; otherwise, pass NO.
	func appendPushScene(withName name: SceneName, parameters: Parameters, animated: Bool)

	/// Appends a view controller modally.
	///
	/// - parameter: name The name of the scene for append.
	func appendModalScene(withName name: SceneName)

	/// Appends a view controller modally.
	///
	/// - parameter: name The name of the scene for append.
	/// - parameter: parameters The parameters that are sent to the scene
	/// - parameter: animated Pass YES to animate the presentation; otherwise, pass NO.
	func appendModalScene(withName name: SceneName, parameters: Parameters, animated: Bool)


	/// Appends a view controller modally inside a UINavigationController.
	///
	/// - parameter: name The name of the scene for append.
	func appendModalWithNavigationScene(withName name: SceneName)

	/// Appends a view controller modally inside a UINavigationController.
	///
	/// - parameter: name The name of the scene for append.
	/// - parameter: parameters The parameters that are sent to the scene
	/// - parameter: animated Pass YES to animate the presentation; otherwise, pass NO.
	func appendModalWithNavigationScene(withName name: SceneName, parameters: Parameters, animated: Bool)
}
