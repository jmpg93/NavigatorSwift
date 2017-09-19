//
//  Cuckoo+Utils.swift
//  NavigatorSwift
//
//  Created by jmpuerta on 19/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
import Foundation

public func verifyNever<M>(_ mock: M) -> M.Verification where M : Mock {
	let matcher = CallMatcher(name: "Never", numberOfExpectedCalls: 0) { expectedCalls, actualCalls in
		return expectedCalls == 0 && actualCalls == expectedCalls
	}

	return verify(mock, matcher)
}
