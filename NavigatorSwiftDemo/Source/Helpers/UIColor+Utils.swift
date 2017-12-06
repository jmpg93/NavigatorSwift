//
//  UIColor+Utils.swift
//  NavigatorSwiftDemo
//
//  Created by jmpuerta on 6/12/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
	static var random: CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}

extension UIColor {
	static var random: UIColor {
		return UIColor(red:   .random,
					   green: .random,
					   blue:  .random,
					   alpha: 1.0)
	}
}
