
//
//  Transition.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 17/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public protocol Transition: UIViewControllerAnimatedTransitioning {
	var modalPresentationStyle: UIModalPresentationStyle { get }
}
