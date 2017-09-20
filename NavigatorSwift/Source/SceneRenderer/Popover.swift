//
//  Popover.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 20/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

open class Popover {
	open var insideNavigationBar: Bool = false
	open var delegate: UIPopoverPresentationControllerDelegate? = nil
	open var permittedArrowDirections: UIPopoverArrowDirection = .any
	open var sourceView: UIView? = nil
	open var sourceRect: CGRect = .zero
	open var canOverlapSourceViewRect: Bool = false
	open var barButtonItem: UIBarButtonItem? = nil
	open var preferredContentSize: CGSize = .zero
}
