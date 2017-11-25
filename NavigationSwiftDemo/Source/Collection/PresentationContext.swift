//
//  PresentationContext.swift
//  NavigationSwiftDemo
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

struct PresentationContext {
	let presentation: Presentation
	let animated: Bool

	var name: String {
		return presentation.value + (animated ? "" : " not animated")
	}
}

extension PresentationContext {
	static let modal = PresentationContext(presentation: .modal, animated: true)
	static let modalNotAnimated = PresentationContext(presentation: .modal, animated: false)
	static let push = PresentationContext(presentation: .push, animated: true)
	static let pushNotAnimated = PresentationContext(presentation: .push, animated: false)
	static let modalNavigation = PresentationContext(presentation: .modalNavigation, animated: true)
	static let modalNavigationNotAnimated = PresentationContext(presentation: .modalNavigation, animated: false)
	static let pop = PresentationContext(presentation: .pop, animated: true)
	static let popNotAnimated = PresentationContext(presentation: .pop, animated: false)
	static let popToRoot = PresentationContext(presentation: .popToRoot, animated: true)
	static let popToRootNotAnimated = PresentationContext(presentation: .popToRoot, animated: false)
	static let dismiss = PresentationContext(presentation: .dismissFirst, animated: true)
	static let dismissNotAnimated = PresentationContext(presentation: .dismissFirst, animated: false)
	static let dismissScene = PresentationContext(presentation: .dismissScene, animated: true)
	static let dismissSceneNotAnimated = PresentationContext(presentation: .dismissScene, animated: false)
	static let dismissAll = PresentationContext(presentation: .dismissAll, animated: true)
	static let dismissAllNotAnimated = PresentationContext(presentation: .dismissAll, animated: false)
	static let set = PresentationContext(presentation: .set([.collection, .collection]), animated: true)
	static let setNotAnimated = PresentationContext(presentation: .set([.collection, .collection]), animated: false)
	static let preview = PresentationContext(presentation: .preview, animated: true)
	static let transition = PresentationContext(presentation: .transition, animated: true)
	static let transitionNotAnimated = PresentationContext(presentation: .transition, animated: false)
	static let popover = PresentationContext(presentation: .popover, animated: true)
	static let popoverNotAnimated = PresentationContext(presentation: .popover, animated: false)
}
