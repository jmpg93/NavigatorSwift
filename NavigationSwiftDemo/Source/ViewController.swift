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

	// @IBOutlet
	@IBOutlet weak var collectionView: UICollectionView!

	// Properties
	fileprivate lazy var navigator: Navigator = {
		return globalNavigator
	}()

	var scenes: [[(ScenePresentationType, Bool)]] = [
		[(.modal, true)],
		[(.push, true)],
		[(.modalInsideNavigationBar, true)],
		[(.modal, true), (.modal, true)],
		[(.modal, true), (.modal, false)],
		[(.push, true), (.push, true)],
		[(.push, false), (.push, true)],
		[(.modalInsideNavigationBar, true), (.push, true)]
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

		return cell
	}
}

// MARK: UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let sceneStack = scenes[indexPath.row]
		let provider = DefaultNavigationRequestProvider()
		let scene = SceneName.collection

		let request = provider.navigationRequest { builder in
			for (presentationType, animated) in sceneStack {
				switch presentationType {
				case .modal:
					builder.appendModalScene(withName: scene, parameters: [:], animated: animated)
				case .push:
					builder.appendPushScene(withName: scene, parameters: [:], animated: animated)
				case .modalInsideNavigationBar:
					builder.appendModalWithNavigationScene(withName: scene, parameters: [:], animated: animated)
				}
			}
		}

		navigator.relativeNavigation(using: request)
	}
}
