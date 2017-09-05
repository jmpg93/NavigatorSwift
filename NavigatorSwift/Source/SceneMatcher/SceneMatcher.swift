//
//  SceneMatcher.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class SceneMatcher {
	enum Constants {
		static let sceneAnimatedDefaultValue = true
		static let scenePresentationTypeDefaultValue: ScenePresentationType = .push
	}

	/// Contains all the scenes registered in the system by their name.
	fileprivate var sceneHandlersByName: [SceneName: SceneHandler] = [:]
	fileprivate var scenePresentationTypeMapper: [String: ScenePresentationType] = [
		Delimiters.presentAsPushValue: .push,
		Delimiters.presenteAsModalValue: .modal,
		Delimiters.presentAsModalWithNavigationControllerValue: .modalInsideNavigationBar
	]

	public init() { }
}

// MARK: - Public Methods

public extension SceneMatcher {
	func registerScene(for sceneHandler: SceneHandler) {
		assert(sceneHandlersByName[sceneHandler.name] == nil, "Already registered scene named \(sceneHandler.name)")
		sceneHandlersByName[sceneHandler.name] = sceneHandler
	}

	func scene(withName name: SceneName, typePresentation: ScenePresentationType, animated: Bool) -> Scene? {
		guard let sceneHandler = sceneHandlersByName[name] else { return nil }

		return Scene(sceneHandler: sceneHandler,
		             parameters: [:],
		             type: typePresentation,
		             animated: animated)
	}

	func matches(from url: URL, externalParameters: Parameters) -> [Scene] {

		var matchedScenes: [Scene] = []

		// Remove pathComponents that are slash.
		guard let pathComponents = url
			.absoluteString
			.removingPercentEncoding?
			.components(separatedBy: "/")
			.filter({ !$0.isEmpty }) else {
				return []
		}

		for pathComponent in pathComponents {
			// Each pathComponent has the form sceneName{presentedAs=push|modal|modalInNav;animated=0|1}
			let sceneName = SceneName(self.sceneName(from: pathComponent))
			let metaData = metadata(from: pathComponent)

			guard let sceneHandlerCandidate = sceneHandlersByName[sceneName] else {
				assertionFailure("Not found scene with name \(sceneName) from URL \(url.absoluteString)")
				matchedScenes.removeAll()
				return []
			}

			var animated = Constants.sceneAnimatedDefaultValue
			var typePresentation = Constants.scenePresentationTypeDefaultValue
			var sceneParameters: Parameters = [:]

			if let animatedParameter = metaData[Delimiters.animatedKey] {
				if animatedParameter == Delimiters.animatedTrueValue {
					animated = true
				} else if animatedParameter == Delimiters.animatedFalseValue {
					animated = false
				}
			}

			if let presentAsKey = metaData[Delimiters.presentAsKey], let type = scenePresentationTypeMapper[presentAsKey] {
				typePresentation = type
			}

			if let externalSceneParameters = externalParameters[sceneHandlerCandidate.name] as? Parameters {
				sceneParameters = externalSceneParameters
			}

			let matchedScene = Scene(sceneHandler: sceneHandlerCandidate,
			                         parameters: sceneParameters,
			                         type: typePresentation,
			                         animated: animated)
			matchedScenes.append(matchedScene)
		}

		return matchedScenes
	}
}

// MARK: - Private

private extension SceneMatcher {
	func sceneName(from pathComponent: String) -> String {
		let sceneName: String

		if let location = pathComponent.characters.index(of: Delimiters.leftMetaDataDelimiter) {
			sceneName = pathComponent.substring(to: location)
		} else {
			sceneName = pathComponent
		}

		return sceneName
	}

	func metadata(from pathComponent: String) -> [String: String] {
		guard let metaDataStart = pathComponent.characters.index(of: Delimiters.leftMetaDataDelimiter) else { return [:] }
		guard let metaDataEndIndex = pathComponent.characters.index(of: Delimiters.rightMetaDataDelimiter) else { return [:] }
		let metaDataStartIndex = pathComponent.index(after: metaDataStart)

		var metadata: [String: String] = [:]

		let metadataString = pathComponent.substring(with: metaDataStartIndex..<metaDataEndIndex)
		let keyValuePairStrings = metadataString.components(separatedBy: Delimiters.metadataSeparator)

		for keyValuePairString in keyValuePairStrings {
			let keyValuePairArray = keyValuePairString.components(separatedBy: Delimiters.keyValuePairSeparator)
			let key = keyValuePairArray.first!
			let valueString = keyValuePairArray.last!
			metadata[key] = valueString
		}

		return metadata
	}
}
