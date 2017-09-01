//
//  NavigationRequestBuilder.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol NavigationRequestBuilder {
	/**
	Append a scene with a push animation.

	@param name The name of the scene for append.
	*/
	func appendPushScene(withName name: String)
	/**
	Append a scene with a push animation.

	@param name The name of the scene for append.
	@param parameters The parameters that are sent to the scene
	@param animated Pass YES to animate the presentation; otherwise, pass NO.
	*/
	func appendPushScene(withName name: String, parameters: Parameters, animated: Bool)
	/**
	Appends a view controller modally.

	@param name The name of the scene for append.
	*/
	func appendModalScene(withName name: String)
	/**
	Appends a view controller modally.

	@param name The name of the scene for append.
	@param parameters The parameters that are sent to the scene
	@param animated Pass YES to animate the presentation; otherwise, pass NO.
	*/
	func appendModalScene(withName name: String, parameters: Parameters, animated: Bool)
	/**
	Appends a view controller modally inside a UINavigationController.

	@param name The name of the scene for append.
	*/
	func appendModalWithNavigationScene(withName name: String)
	/**
	Appends a view controller modally inside a UINavigationController.

	@param name The name of the scene for append.
	@param parameters The parameters that are sent to the scene
	@param animated Pass YES to animate the presentation; otherwise, pass NO.
	*/
	func appendModalWithNavigationScene(withName name: String, parameters: Parameters, animated: Bool)
}
