//
//  Section.swift
//  NavigatorSwiftDemo
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct Section {
	let name: String
	let sequences: [PresentationSequence]
}

extension Section {
	static let all: [Section] = [
		Section(name: "Test sequences", sequences: PresentationSequence.testSequences),
		Section(name: "Base sequences", sequences: PresentationSequence.baseSequences),
		Section(name: "Non animated sequences", sequences: PresentationSequence.nonAnimatedSequences),
	]
}
