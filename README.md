# NavigatorSwift

NavigatorSwift is a framework to easily navigate between your views.

## How does it work

### Create a navigator
```swift
// NavigationController container based navigator
let navigator = NavNavigator(window: UIWindow())

// TabBarController container based navigator
let navigator = TabNavigator(window: UIWindow())

// Custom container based navigator
let navigator = ContainerNavigator(window: UIWindow())
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

	func view(with parameters: Parameters) -> UIViewController {
		let vc = UIViewController()
		vc.view.backgroundColor = .red
		return vc
	}
	
	// Optional
	func reload(_ viewController: UIViewController, parameters: Parameters) {
		// Do nothing by default
	}
	
	// Optional
	var isReloadable: Bool {
		return true
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
Calls the method reload from the scene handler.

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
- Traverse (get the current stack hierarchy; sceneName and presentationType):
```swift
navigator.traverse { state in
	if state.names.contains(.collection) {
		// Do something
	}
}
```
- Relative stack navigation using builder:
```swift
navigator.build { builder in
	builder.modal(.contact)
	builder.modalNavigation(.detail)
	builder.push(.avatar)
}
```
If you use relative navigation, you can add new scenes over the current hierarchy.

- Absolute stack navigation using builder (the current stack will be recycled and reloaded if possible):
```swift
navigator.build { builder in
	builder.root(name: .home)
	builder.modalNavigation(.login)
}
```
If you use absolute navigation, the hierarchy will be rebuilded from root. If the current hierarchy match the targeted hierarchy, the view controllers will be recycled and reloaded.

Use absolute navigation to **present a certain hierarchy no matter what is the current state**.

- Operation based navigation:

For more complex navigation you can create and concatenate operations that will be executed serially. This can be easyly archived by creating a new ```SceneOperation``` and extending the ```Navigator``` protocol.

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
- Interceptors:

By implementing the protocol `SceneOperationInterceptor` you can intercept all the operations being executed by the navigator.
This protocol allows you to change the behavior of the navigator in some cases. 

For example for displaying the contacts persmissions alert just before presenting some edit contact view:
```swift
class ContactsPermissionsInterceptor: SceneOperationInterceptor {
	func operation(with operation: SceneOperation, context: SceneOperationContext) -> SceneOperation? {
		return ShowContactPermissionsIfNeededSceneOperation().then(operation)
	}

	func shouldIntercept(operation: SceneOperation, context: SceneOperationContext) -> Bool {
		return context.targetState.names.contains(.editContact)
	}
}
```
If you want to stop the execution of the operation, you must return nil on ```operation(with:context:)```

To start intercepting, a registration of the interceptor is needed.
```swift
navigator.register(ContactsPermissionsInterceptor())
```
