//
//  Collection.swift
//  NavigatorSwiftDemo
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

		static let rootParameters = [CollectionSceneHandler.Parameter.stateLabel: Constants.defaultStateText]
		static let modalParameters = [CollectionSceneHandler.Parameter.stateLabel: "modal"]
		static let pushParameters = [CollectionSceneHandler.Parameter.stateLabel: "push"]
		static let modalNavParameters = [CollectionSceneHandler.Parameter.stateLabel: "modalNav"]
		static let transitionParameters = [CollectionSceneHandler.Parameter.stateLabel: "transition"]
		static let popoverParameters = [CollectionSceneHandler.Parameter.stateLabel: "popover"]

		static func rootSetParameters(index: Int) -> Parameters {
			return [CollectionSceneHandler.Parameter.stateLabel: "root set \(index + 1) scenes"]
		}
	}

	let transition = LeftTransition()
	let sections = Section.all

	// @IBOutlet
	@IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	
	// Properties
	var stateText = Constants.defaultStateText
	var color = UIColor.random
	var navigator: TabNavigator {
		return globalNavigator
	}
	
	static func loadFromStoryBoard() -> Collection {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Collection") as! Collection
	}

	deinit {
		// TODO: In some cases the view is created (and instantly deallocated) even if you know the view cannot be presented.
		//print("DEINIT")
	}
}

// MARK: View life cycle

extension Collection {
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		cell.sceneNameLabel.backgroundColor = color
		
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

		for context in sequence.contexts {
			switch context.presentation {
			case .modal:
				navigator.present(.collection, parameters: Constants.modalParameters, animated: context.animated)
			case .push:
				navigator.push(.collection, parameters: Constants.pushParameters, animated: context.animated)
			case .set(let scenes):
				navigator.build { builder in
					builder.root(.tabBar, parameters: Constants.rootParameters)
					builder.tab(.blue)
					for (index, scene) in scenes.enumerated() {
						builder.present(scene, parameters: Constants.rootSetParameters(index: index), animated: context.animated)
					}
				}
			case .modalNavigation:
				navigator.presentNavigation(.collection, parameters: Constants.modalNavParameters, animated: context.animated)
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
				navigator.transition(to: .collection, parameters: Constants.transitionParameters, with: transition)
			case .popover:
				let cell = collectionView.cellForItem(at: indexPath)!
				navigator.popover(.collection, parameters: Constants.popoverParameters, from: cell)
			case .deeplink:
				assertionFailure("Not yet url")
			case .preview:
				navigator.present(.collection, parameters: Constants.modalParameters, animated: context.animated)
			case .rootModal:
				navigator.build { builder in
					builder.root(.tabBar, parameters: Constants.rootParameters)
					builder.tab(.blue)
					builder.present(.collection, parameters: Constants.modalParameters)
				}
			case .rootModalNav:
				navigator.build { builder in
					builder.root(.tabBar, parameters: Constants.rootParameters)
					builder.tab(.blue)
					builder.presentNavigation(.collection, parameters: Constants.modalNavParameters)
				}
			case .rootModalNavPush:
				navigator.build { builder in
					builder.root(.tabBar, parameters: Constants.rootParameters)
					builder.tab(.blue)
					builder.presentNavigation(.collection, parameters: Constants.modalNavParameters)
					builder.push(.collection, parameters: Constants.pushParameters)
				}
			}
		}
	}
}

protocol BlueNavigator {
	func navigateToBlue(userId: String)
}

extension TabNavigator: BlueNavigator {
	func navigateToBlue(userId: String) {
		build { builder in
			builder.root(.tabBar)
			builder.tab(.blue, parameters: ["userId": userId])
		}
	}
}
