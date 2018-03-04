//
//  NavigatorFlowSequence.swift
//  NavigatorSwiftDemo
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct NavigatorFlowSequence {
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

extension NavigatorFlowSequence {
	static let testSequences: [NavigatorFlowSequence] = [
		NavigatorFlowSequence(contexts: [.modal]),
		NavigatorFlowSequence(contexts: [.push]),
		NavigatorFlowSequence(contexts: [.modalNavigation]),
		NavigatorFlowSequence(contexts: [.modal, .dismiss]),
		NavigatorFlowSequence(contexts: [.modal, .dismissScene]),
		NavigatorFlowSequence(contexts: [.modal, .dismissAll]),
		NavigatorFlowSequence(contexts: [.popover]),
		NavigatorFlowSequence(contexts: [.transition]),
		NavigatorFlowSequence(contexts: [.preview]),
		NavigatorFlowSequence(contexts: [.push, .pop]),
		NavigatorFlowSequence(contexts: [.push, .popToRoot]),
		NavigatorFlowSequence(contexts: [.set]),
		NavigatorFlowSequence(contexts: [.dismissAll]),
		NavigatorFlowSequence(contexts: [.popToRoot]),
		NavigatorFlowSequence(contexts: [.modal, .modal]),
		NavigatorFlowSequence(contexts: [.push, .push]),
		NavigatorFlowSequence(contexts: [.modalNavigation, .push]),
		NavigatorFlowSequence(contexts: [.rootModal]),
		NavigatorFlowSequence(contexts: [.rootModalNav]),
		NavigatorFlowSequence(contexts: [.rootModalNavPush])
	]

	static let baseSequences: [NavigatorFlowSequence] = [
		NavigatorFlowSequence(contexts: [.modal]),
		NavigatorFlowSequence(contexts: [.push]),
		NavigatorFlowSequence(contexts: [.modalNavigation]),
		NavigatorFlowSequence(contexts: [.dismiss]),
		NavigatorFlowSequence(contexts: [.dismissScene]),
		NavigatorFlowSequence(contexts: [.dismissAll]),
		NavigatorFlowSequence(contexts: [.popover]),
		NavigatorFlowSequence(contexts: [.transition]),
		NavigatorFlowSequence(contexts: [.preview]),
		NavigatorFlowSequence(contexts: [.pop]),
		NavigatorFlowSequence(contexts: [.popToRoot]),
		NavigatorFlowSequence(contexts: [.set])
	]

	static let nonAnimatedSequences: [NavigatorFlowSequence] = [
		NavigatorFlowSequence(contexts: [.modalNotAnimated]),
		NavigatorFlowSequence(contexts: [.pushNotAnimated]),
		NavigatorFlowSequence(contexts: [.modalNavigationNotAnimated]),
		NavigatorFlowSequence(contexts: [.popoverNotAnimated]),
		NavigatorFlowSequence(contexts: [.transitionNotAnimated]),
		NavigatorFlowSequence(contexts: [.dismissNotAnimated]),
		NavigatorFlowSequence(contexts: [.dismissSceneNotAnimated]),
		NavigatorFlowSequence(contexts: [.dismissAllNotAnimated]),
		NavigatorFlowSequence(contexts: [.setNotAnimated]),
		NavigatorFlowSequence(contexts: [.popNotAnimated]),
		NavigatorFlowSequence(contexts: [.popToRootNotAnimated])
	]
}
