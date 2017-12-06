//
//  Array+Utils.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 6/12/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
	func after(item: Element) -> Element? {
		if let index = self.index(of: item), index + 1 < self.count {
			return self[index + 1]
		}
		return nil
	}
}
