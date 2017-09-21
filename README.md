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
navigator.presentNavigationController(.login)
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
navigator.dismiss(.login)
```
- Push:
```swift
navigator.push(.login)
```
- Pop to root view:
```swift
navigator.popToRoot()
```
- Pop first view:
```swift
navigator.pop(animated: true)
```
- Deep link:
```swift
navigator.deepLink(url: someDeepLinkURL)
```
- Force touch preview.
```swift
navigator.preview(.loginm, from: someViewController, at: someSourceView)
```
- Popover presentation:
```swift
navigator.popover(.collection, from: somView)
```
- Transition:
```swift
navigator.transition(to: .login, with: someInteractiveTransition)
```
- View creation:
```swift
let loginView = navigator.view(for: .login)
```
- Stack navigation using builder:
```swift
navigator.navigate(using: { builder in
	builder.appendModal(name: .login)
})
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
