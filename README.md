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

	var isViewControllerRecyclable: Bool {
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
navigator.presentNavigationController(.login)
```
- Dismiss all views:
```swift
navigator.dismissAll(animated: true)
```
- Dismiss first view:
```swift
navigator.dismiss(animated: true)
```
- Dismiss by scene:
```swift
navigator.dismiss(.login, animated: true)
```
- Push:
```swift
navigator.push(.login)
```
- Pop to root view:
```swift
navigator.popToRoot(animated: true)
```
- Pop first view:
```swift
navigator.pop(animated: true)
```
- Deep link (some configuration may be needed):
```swift
navigator.deepLink(url: someDeepLinkURL)
```
- Force touch preview.
```swift
navigator.preview(from: someViewController, for: .login, at: someSourceView)
```
- Transition:
```swift
navigator.transition(to: .login, with: someInteractiveTransition)
```
- View creation:
```swift
navigator.transition(to: .login, with: someInteractiveTransition)
```
- Stack navigation using builder:
```swift
navigator.view(for: .login)
```
- Absolute navigation using builder (the current stack will be recycled):
```swift
navigator.navigate(using: { builder in
	builder.appendModal(name: .login)
	builder.appendModalWithNavigation(name: .login)
	builder.appendPush(name: .login)
	builder.navigateAbsolutely()
})
```
- ~~Popover presentation~~:
NOT YET
