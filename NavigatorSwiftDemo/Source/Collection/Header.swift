//
//  Header.swift
//  NavigatorSwiftDemo
//
//  Created by jmpuerta on 25/11/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

class Header: UICollectionReusableView {
	lazy var sceneNameLabel: UILabel = {
		let label = UILabel(frame: self.bounds)
		label.textAlignment = .left
		label.textColor = .black
		label.backgroundColor = .white
		label.numberOfLines = 0
		label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(label)
		return label
	}()
}
