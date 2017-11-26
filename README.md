# NavigatorSwift

NavigatorSwift is a framework to easily navigate between your views.

## How does it work

### Create a navigator
```swift
let window = UIWindow()
let navigator = NavNavigator(window: window)
```

### Create a Scene and register it
```swift
extension SceneName {
	static let login: SceneName = "Login"
}

class LoginScene: SceneHandler {
	var name: SceneName {
		return .login
	}

	func buildViewController(with parameters: Parameters) -> UIViewController {
		let vc = UIViewController()
		vc.view.backgroundColor = .red
		return vc
	}
}
```

```swift
navigator.register(LoginScene())
```

### Set root scene and navigate!
```swift
navigator.root(.login)
navigator.push(.someScene)
```

## Features

- Present:
```swift
navigator.present(.login)
```
- Present inside navigation controller:
```swift
navigator.presentNavigation(.someScene)
```
- Dismiss all views:
```swift
navigator.dismissAll()
```
- Dismiss first view:
```swift
navigator.dismiss()
```
- Dismiss by scene:
```swift
navigator.dismiss(.someScene)
```
- Push:
```swift
navigator.push(.someScene)
```
- Pop to root view:
```swift
navigator.popToRoot()
```
- Pop first view:
```swift
navigator.pop()
```
- Reload:
```swift
navigator.reload(.someScene)
```
- URLs:
```swift
navigator.url(someURL)
```
- Force touch preview.
```swift
navigator.preview(.someScene, from: someViewController, at: someSourceView)
```
- Popover presentation:
```swift
navigator.popover(.someScene, from: somView)
```
- Transition:
```swift
navigator.transition(to: .someScene, with: someInteractiveTransition)
```
- View creation:
```swift
let loginView = navigator.view(for: .login)
```
- Stack navigation using builder:
```swift
navigator.build { builder in
	builder.modal(.detail)
}
```
- Absolute navigation using builder (the current stack will be recycled):
```swift
navigator.navigate(using: { builder in
	builder.root(name: .login) // The root is set
	builder.modalNavigation(.home)
	builder.push(.detail)
})
```
- Operation based navigation. For more complex navigation you can create and concatenate operation that will be executed serially. This can be easyly archived by creating a new ```SceneOperation``` and exteding the ```Navigator``` protocol.

```swift
class SomeOperation {
	fileprivate var scenes: [Scene]
	fileprivate let renderer: SceneRenderer

	init(scenes: [Scene], renderer: SceneRenderer) {
		self.scenes = scenes
		self.renderer = renderer
	}
}

extension SomeOperation: SceneOperation {
	func execute(with completion: CompletionBlock?) {
		let dismissAllOperation = renderer.dismissAll(animated: true)
		let addScenes = renderer.add(scenes: scenes)
		let reloadLast = renderer.reload(scene: scenes.last!)

		let complexOperation = dismissAllOperation
			.then(addScenes)
			.then(reloadLast)
			.execute(with: completion)
	}
}
```
