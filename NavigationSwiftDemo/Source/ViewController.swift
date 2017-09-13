//
//  ViewController.swift
//  NavigationSwiftDemo
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit
import NavigatorSwift

class Cell: UICollectionViewCell {
	lazy var sceneNameLabel: UILabel = {
		let label = UILabel(frame: self.bounds)
		label.textAlignment = .center
		label.textColor = .white
		label.backgroundColor = .blue
		label.numberOfLines = 0
		label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(label)
		return label
	}()
}

enum Presentation {
	case presentation(ScenePresentationType)
	case dismissFirst
	case dismissScene
	case dismissAll
	case pop
	case popToRoot
	case deeplink
	case preview

	var value: String {
		switch self {
		case .pop:
			return "pop"
		case .popToRoot:
			return "popToRoot"
		case .dismissScene:
			return "dismissScene"
		case .dismissFirst:
			return "dismissFirst"
		case .dismissAll:
			return "dismissAll"
		case .deeplink:
			return "deeplink"
		case .preview:
			return "preview"
		case .presentation(let type):
			return "\(type)"
		}
	}
}

class Layout: UICollectionViewFlowLayout {
	override func prepare() {
		super.prepare()
		guard let collectionView = collectionView else { return }
		let width = (collectionView.bounds.width - 3) / 3.0
		itemSize = CGSize(width: width, height: width)
		minimumLineSpacing = 1
		minimumInteritemSpacing = 1
	}
}

class ViewController: UIViewController {
	fileprivate enum Constants {
		static let cellIdentifier = "Cell"
	}

	var peek: UIViewControllerPreviewingDelegate?

	// @IBOutlet
	@IBOutlet weak var collectionView: UICollectionView!

	// Properties
	fileprivate lazy var navigator: NavNavigator = {
		return globalNavigator
	}()

	var scenes: [[(Presentation, Bool)]] = [
		[(.presentation(.modal), true)],
		[(.presentation(.push), true)],
		[(.presentation(.modalNavigation), true)],
		[(.presentation(.modal), true), (.presentation(.modal), true)],
		[(.presentation(.modal), true), (.presentation(.modal), false)],
		[(.presentation(.push), true), (.presentation(.push), true)],
		[(.presentation(.push), false), (.presentation(.push), true)],
		[(.presentation(.modalNavigation), true), (.presentation(.push), true)],
		[(.pop, true)],
		[(.pop, false)],
		[(.popToRoot, true)],
		[(.popToRoot, false)],
		[(.dismissFirst, true)],
		[(.dismissFirst, false)],
		[(.dismissAll, true)],
		[(.dismissAll, false)],
		[(.dismissScene, true)],
		[(.dismissScene, false)],
		[(.preview, false)]
	]
}

// MARK: View life cycle

extension ViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		automaticallyAdjustsScrollViewInsets = false
		collectionView.register(Cell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
	}
}

// MARK: UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView,
	                    numberOfItemsInSection section: Int) -> Int {
		return scenes.count
	}

	func collectionView(_ collectionView: UICollectionView,
	                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! Cell

		let text = scenes[indexPath.row]
			.map { "\($0.value) - \($1)" }
			.reduce("") {  $0 + "\n" + $1 }
		
		cell.sceneNameLabel.text = text

		if text.contains("preview") {
			navigator.preview(from: self, for: .collection, at: cell)
		} else {
			navigator.removePreview(at: cell)
		}

		return cell
	}
}

// MARK: UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let scenes = self.scenes[indexPath.item]
		let animated = scenes.first!.1
		switch scenes.first!.0 {
		case .pop:
			navigator.pop(animated: animated)
		case .popToRoot:
			navigator.popToRoot(animated: animated)
		case .dismissScene:
			navigator.dismiss(.collection, animated: animated)
		case .dismissFirst:
			navigator.dismiss(animated: animated)
		case .dismissAll:
			navigator.dismissAll(animated: animated)
		default:
			break
		}

		navigator.navigate(using: { builder in
			for (presentationType, animated) in scenes {
				guard case .presentation(let type) = presentationType else {
					return
				}
				switch type {
				case .modal:
					builder.appendModal(name: .collection, animated: animated)
				case .push:
					builder.appendPush(name: .collection, animated: animated)
				case .modalNavigation:
					builder.appendModalWithNavigation(name: .collection, animated: animated)
				}
			}
		})
	}
}
