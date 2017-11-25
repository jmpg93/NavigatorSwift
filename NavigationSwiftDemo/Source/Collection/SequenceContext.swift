//
//  SequenceContext.swift
//  NavigationSwiftDemo
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct PresentationSequence {
	let contexts: [PresentationContext]

	var name: String {
		return contexts
			.map({ $0.name })
			.enumerated()
			.map({ offset, name in
				if offset == contexts.indices.last {
					return name
				} else {
					return name + "\n"
				}
			}).reduce("") { $0 + $1 }
	}

	var hasPreview: Bool {
		return !contexts
			.filter({ $0.presentation.value == Presentation.preview.value })
			.isEmpty
	}
}

extension PresentationSequence {
	static let testSequences: [PresentationSequence] = [
		PresentationSequence(contexts: [.modal]),
		PresentationSequence(contexts: [.push]),
		PresentationSequence(contexts: [.modalNavigation]),
		PresentationSequence(contexts: [.modal, .dismiss]),
		PresentationSequence(contexts: [.modal, .dismissScene]),
		PresentationSequence(contexts: [.modal, .dismissAll]),
		PresentationSequence(contexts: [.popover]),
		PresentationSequence(contexts: [.transition]),
		PresentationSequence(contexts: [.preview]),
		PresentationSequence(contexts: [.push, .pop]),
		PresentationSequence(contexts: [.push, .popToRoot]),
		PresentationSequence(contexts: [.set]),
		PresentationSequence(contexts: [.dismissAll]),
		PresentationSequence(contexts: [.popToRoot])
	]

	static let baseSequences: [PresentationSequence] = [
		PresentationSequence(contexts: [.modal]),
		PresentationSequence(contexts: [.push]),
		PresentationSequence(contexts: [.modalNavigation]),
		PresentationSequence(contexts: [.dismiss]),
		PresentationSequence(contexts: [.dismissScene]),
		PresentationSequence(contexts: [.dismissAll]),
		PresentationSequence(contexts: [.popover]),
		PresentationSequence(contexts: [.transition]),
		PresentationSequence(contexts: [.preview]),
		PresentationSequence(contexts: [.pop]),
		PresentationSequence(contexts: [.popToRoot]),
		PresentationSequence(contexts: [.set]),
	]

	static let nonAnimatedSequences: [PresentationSequence] = [
		PresentationSequence(contexts: [.modalNotAnimated]),
		PresentationSequence(contexts: [.pushNotAnimated]),
		PresentationSequence(contexts: [.modalNavigationNotAnimated]),
		PresentationSequence(contexts: [.popoverNotAnimated]),
		PresentationSequence(contexts: [.transitionNotAnimated]),
		PresentationSequence(contexts: [.dismissNotAnimated]),
		PresentationSequence(contexts: [.dismissSceneNotAnimated]),
		PresentationSequence(contexts: [.dismissAllNotAnimated]),
		PresentationSequence(contexts: [.setNotAnimated]),
		PresentationSequence(contexts: [.popNotAnimated]),
		PresentationSequence(contexts: [.popToRootNotAnimated])
	]

	static let combinedSequences: [PresentationSequence] = [
		PresentationSequence(contexts: [.modal, .modal]),
		PresentationSequence(contexts: [.push, .push]),
		PresentationSequence(contexts: [.modalNavigation, .push])
	]
}
