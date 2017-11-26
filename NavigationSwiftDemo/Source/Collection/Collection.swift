//
//  Collection.swift
//  NavigationSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit
import NavigatorSwift

class Collection: UIViewController {
	fileprivate enum Constants {
		static let cellIdentifier = "Cell"
		static let headerIdentifier = "Header"
		static let stateLabelIdentifier = "StateLabel"

		static let defaultStateText = "root"
	}

	var stateText = Constants.defaultStateText
	let transition = LeftTransition()
	let sections = Section.all

	// @IBOutlet
	@IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!

	// Properties
	fileprivate var navigator: NavNavigator {
		return globalNavigator
	}

	deinit {
		print("DEINIT")
	}
}

// MARK: View life cycle

extension Collection {
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Collection"
		stateLabel.text = stateText
		stateLabel.accessibilityIdentifier = Constants.stateLabelIdentifier
		automaticallyAdjustsScrollViewInsets = false
		collectionView.register(Cell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
	}
}

// MARK: UICollectionViewDataSource

extension Collection: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return sections.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sections[section].sequences.count
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard kind == UICollectionElementKindSectionHeader else {
			return UICollectionReusableView()
		}

		let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as! Header
		header.sceneNameLabel.text = sections[indexPath.section].name

		return header
		
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! Cell

		let sequence = sections[indexPath.section].sequences[indexPath.item]
		cell.sceneNameLabel.text = sequence.name

		if sequence.hasPreview {
			navigator.preview(.collection, from: self, at: cell)
		} else {
			navigator.removePreview(at: cell)
		}

		return cell
	}
}

// MARK: UICollectionViewDataSource

extension Collection: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let sequence = sections[indexPath.section].sequences[indexPath.item]
		let parameters = self.parameters(with: sequence)

		for context in sequence.contexts {
			switch context.presentation {
			case .modal:
				navigator.present(.collection, parameters: parameters, animated: context.animated)
			case .push:
				navigator.push(.collection, parameters: parameters, animated: context.animated)
			case .set(let scenes):
				navigator.build { builder in
					for scene in scenes {
						builder.appendModal(name: scene, parameters: parameters, animated: context.animated)
					}
					builder.navigateAbsolutely()
				}
			case .modalNavigation:
				navigator.presentNavigationController(.collection, parameters: parameters, animated: context.animated, completion: nil)
			case .pop:
				navigator.pop(animated: context.animated)
			case .popToRoot:
				navigator.popToRoot(animated: context.animated)
			case .dismissScene:
				navigator.dismiss(.collection, animated: context.animated)
			case .dismissFirst:
				navigator.dismiss(animated: context.animated)
			case .dismissAll:
				navigator.dismissAll(animated: context.animated)
			case .transition:
				navigator.transition(to: .collection, parameters: parameters, with: transition)
			case .popover:
				let cell = collectionView.cellForItem(at: indexPath)!
				navigator.popover(.collection, parameters: parameters, from: cell)
			case .deeplink:
				assertionFailure("Not yet url")
			case .preview:
				let cell = collectionView.cellForItem(at: indexPath)!
				navigator.preview(.collection, from: self, at: cell, parameters: parameters)
			case .recycle:
				navigator.build { builder in
					builder.appendModalWithNavigation(name: .collection)
					builder.appendPush(name: .collection)
					builder.navigateAbsolutely()
				}
			}
		}
	}
}

extension Collection {
	func parameters(with presentationSequence: PresentationSequence) -> Parameters {
		return [CollectionScenHandler.Parameter.stateLabel:presentationSequence.name]
	}
}
