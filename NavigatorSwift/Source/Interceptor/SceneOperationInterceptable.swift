//
//  SceneOperationInterceptable.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/2/18.
//  Copyright © 2018 Jose Maria Puerta. All rights reserved.
//

import Foundation

public protocol SceneOperationInterceptable: SceneOperation {
	func context() -> InterceptorContext
}
