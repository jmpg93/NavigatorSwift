//
//  NavigatorFlowSection.swift
//  NavigatorSwiftDemo
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct NavigatorFlowSection {
	let name: String
	let sequences: [NavigatorFlowSequence]
}

extension NavigatorFlowSection {
	static let all: [NavigatorFlowSection] = [
		NavigatorFlowSection(name: "Test sequences", sequences: NavigatorFlowSequence.testSequences),
		NavigatorFlowSection(name: "Base sequences", sequences: NavigatorFlowSequence.baseSequences),
		NavigatorFlowSection(name: "Non animated sequences", sequences: NavigatorFlowSequence.nonAnimatedSequences),
	]
}
