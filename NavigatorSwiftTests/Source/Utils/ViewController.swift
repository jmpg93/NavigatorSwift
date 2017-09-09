//
//  ViewController.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

open class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
}

open class Window: UIWindow {
	override open var rootViewController: UIViewController? {
		get {
			return super.rootViewController
		}

		set {
			super.rootViewController = newValue
		}
	}

	override open func makeKeyAndVisible() {

	}
}
