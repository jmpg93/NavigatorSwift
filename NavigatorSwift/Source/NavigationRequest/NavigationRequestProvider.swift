//
//  NavigationRequestProvider.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol NavigationRequestProvider {
	func navigationRequest(using builderBlock: NavigationRequestBuilderBlock) -> NavigationRequest
}
