//: Playground - noun: a place where people can play

import UIKit
import NavigatorSwift

class LoginScenhandler: SceneHandler {
	var name: String {
		return "Login"
	}

	var viewControllerClass: AnyClass {
		return UIViewController.self
	}

	func buildViewController(with parameters: Parameters) -> UIViewController {
		return UIViewController()
	}
}
