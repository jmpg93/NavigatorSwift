// MARK: - Mocks generated from file: NavigatorSwift/Source/Domain/Scene.swift at 2017-09-16 23:52:51 +0000

//
//  Scene.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation

class MockScene: Scene, Cuckoo.Mock {
    typealias MocksType = Scene
    typealias Stubbing = __StubbingProxy_Scene
    typealias Verification = __VerificationProxy_Scene
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: Scene?

    func spy(on victim: Scene) -> Self {
        observed = victim
        return self
    }

    

    

    

    struct __StubbingProxy_Scene: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
    }


    struct __VerificationProxy_Scene: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
    }


}

 class SceneStub: Scene {
    

    

    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneHandler/SceneHandler.swift at 2017-09-16 23:52:51 +0000

//
//  SceneHandler.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation
import UIKit

class MockSceneHandler: SceneHandler, Cuckoo.Mock {
    typealias MocksType = SceneHandler
    typealias Stubbing = __StubbingProxy_SceneHandler
    typealias Verification = __VerificationProxy_SceneHandler
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: SceneHandler?

    func spy(on victim: SceneHandler) -> Self {
        observed = victim
        return self
    }

    
    // ["name": "name", "accesibility": "public", "@type": "InstanceVariable", "type": "SceneName", "isReadOnly": true]
     var name: SceneName {
        get {
            return cuckoo_manager.getter("name", original: observed.map { o in return { () -> SceneName in o.name }})
        }
        
    }
    
    // ["name": "isViewControllerRecyclable", "accesibility": "public", "@type": "InstanceVariable", "type": "Bool", "isReadOnly": true]
     var isViewControllerRecyclable: Bool {
        get {
            return cuckoo_manager.getter("isViewControllerRecyclable", original: observed.map { o in return { () -> Bool in o.isViewControllerRecyclable }})
        }
        
    }
    

    

    
    public func buildViewController(with parameters: Parameters)  -> UIViewController {
        
        return cuckoo_manager.call("buildViewController(with: Parameters) -> UIViewController",
            parameters: (parameters),
            original: observed.map { o in
                return { (parameters: Parameters) -> UIViewController in
                    o.buildViewController(with: parameters)
                }
            })
        
    }
    
    public func reload(_ viewController: UIViewController, parameters: Parameters)  {
        
        return cuckoo_manager.call("reload(_: UIViewController, parameters: Parameters)",
            parameters: (viewController, parameters),
            original: observed.map { o in
                return { (viewController: UIViewController, parameters: Parameters) in
                    o.reload(viewController, parameters: parameters)
                }
            })
        
    }
    

    struct __StubbingProxy_SceneHandler: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var name: Cuckoo.ToBeStubbedReadOnlyProperty<SceneName> {
            return .init(manager: cuckoo_manager, name: "name")
        }
        
        var isViewControllerRecyclable: Cuckoo.ToBeStubbedReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "isViewControllerRecyclable")
        }
        
        
        func buildViewController<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.StubFunction<(Parameters), UIViewController> where M1.MatchedType == Parameters {
            let matchers: [Cuckoo.ParameterMatcher<(Parameters)>] = [wrap(matchable: parameters) { $0 }]
            return .init(stub: cuckoo_manager.createStub("buildViewController(with: Parameters) -> UIViewController", parameterMatchers: matchers))
        }
        
        func reload<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ viewController: M1, parameters: M2) -> Cuckoo.StubNoReturnFunction<(UIViewController, Parameters)> where M1.MatchedType == UIViewController, M2.MatchedType == Parameters {
            let matchers: [Cuckoo.ParameterMatcher<(UIViewController, Parameters)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub("reload(_: UIViewController, parameters: Parameters)", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_SceneHandler: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        
        var name: Cuckoo.VerifyReadOnlyProperty<SceneName> {
            return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var isViewControllerRecyclable: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "isViewControllerRecyclable", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
        @discardableResult
        func buildViewController<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.__DoNotUse<UIViewController> where M1.MatchedType == Parameters {
            let matchers: [Cuckoo.ParameterMatcher<(Parameters)>] = [wrap(matchable: parameters) { $0 }]
            return cuckoo_manager.verify("buildViewController(with: Parameters) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func reload<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ viewController: M1, parameters: M2) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIViewController, M2.MatchedType == Parameters {
            let matchers: [Cuckoo.ParameterMatcher<(UIViewController, Parameters)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
            return cuckoo_manager.verify("reload(_: UIViewController, parameters: Parameters)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class SceneHandlerStub: SceneHandler {
    
     var name: SceneName {
        get {
            return DefaultValueRegistry.defaultValue(for: (SceneName).self)
        }
        
    }
    
     var isViewControllerRecyclable: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    

    

    
    public func buildViewController(with parameters: Parameters)  -> UIViewController {
        return DefaultValueRegistry.defaultValue(for: UIViewController.self)
    }
    
    public func reload(_ viewController: UIViewController, parameters: Parameters)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}




// MARK: - Mocks generated from file: NavigatorSwiftTests/Source/Utils/ViewController.swift at 2017-09-16 23:52:51 +0000

//
//  ViewController.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 3/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation
import UIKit

class MockNavigationController: NavigationController, Cuckoo.Mock {
    typealias MocksType = NavigationController
    typealias Stubbing = __StubbingProxy_NavigationController
    typealias Verification = __VerificationProxy_NavigationController
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: NavigationController?

    func spy(on victim: NavigationController) -> Self {
        observed = victim
        return self
    }

    

    

    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)?)  {
        
        return cuckoo_manager.call("dismiss(animated: Bool, completion: (() -> Void)?)",
            parameters: (flag, completion),
            original: observed.map { o in
                return { (flag: Bool, completion: (() -> Void)?) in
                    o.dismiss(animated: flag, completion: completion)
                }
            })
        
    }
    

    struct __StubbingProxy_NavigationController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func dismiss<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(animated flag: M1, completion: M2) -> Cuckoo.StubNoReturnFunction<(Bool, (() -> Void)?)> where M1.MatchedType == Bool, M2.MatchedType == (() -> Void)? {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, (() -> Void)?)>] = [wrap(matchable: flag) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub("dismiss(animated: Bool, completion: (() -> Void)?)", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_NavigationController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func dismiss<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(animated flag: M1, completion: M2) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == Bool, M2.MatchedType == (() -> Void)? {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, (() -> Void)?)>] = [wrap(matchable: flag) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return cuckoo_manager.verify("dismiss(animated: Bool, completion: (() -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class NavigationControllerStub: NavigationController {
    

    

    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)?)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}



class MockViewController: ViewController, Cuckoo.Mock {
    typealias MocksType = ViewController
    typealias Stubbing = __StubbingProxy_ViewController
    typealias Verification = __VerificationProxy_ViewController
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: ViewController?

    func spy(on victim: ViewController) -> Self {
        observed = victim
        return self
    }

    

    

    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)?)  {
        
        return cuckoo_manager.call("dismiss(animated: Bool, completion: (() -> Void)?)",
            parameters: (flag, completion),
            original: observed.map { o in
                return { (flag: Bool, completion: (() -> Void)?) in
                    o.dismiss(animated: flag, completion: completion)
                }
            })
        
    }
    

    struct __StubbingProxy_ViewController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func dismiss<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(animated flag: M1, completion: M2) -> Cuckoo.StubNoReturnFunction<(Bool, (() -> Void)?)> where M1.MatchedType == Bool, M2.MatchedType == (() -> Void)? {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, (() -> Void)?)>] = [wrap(matchable: flag) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub("dismiss(animated: Bool, completion: (() -> Void)?)", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_ViewController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func dismiss<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(animated flag: M1, completion: M2) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == Bool, M2.MatchedType == (() -> Void)? {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, (() -> Void)?)>] = [wrap(matchable: flag) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return cuckoo_manager.verify("dismiss(animated: Bool, completion: (() -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class ViewControllerStub: ViewController {
    

    

    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)?)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}



class MockWindow: Window, Cuckoo.Mock {
    typealias MocksType = Window
    typealias Stubbing = __StubbingProxy_Window
    typealias Verification = __VerificationProxy_Window
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: Window?

    func spy(on victim: Window) -> Self {
        observed = victim
        return self
    }

    
    // ["name": "didCallMakeKeyAndVisible", "accesibility": "", "@type": "InstanceVariable", "type": "Bool", "isReadOnly": false]
     override var didCallMakeKeyAndVisible: Bool {
        get {
            return cuckoo_manager.getter("didCallMakeKeyAndVisible", original: observed.map { o in return { () -> Bool in o.didCallMakeKeyAndVisible }})
        }
        
        set {
            cuckoo_manager.setter("didCallMakeKeyAndVisible", value: newValue, original: observed != nil ? { self.observed?.didCallMakeKeyAndVisible = $0 } : nil)
        }
        
    }
    

    

    
    public override func makeKeyAndVisible()  {
        
        return cuckoo_manager.call("makeKeyAndVisible()",
            parameters: (),
            original: observed.map { o in
                return { () in
                    o.makeKeyAndVisible()
                }
            })
        
    }
    

    struct __StubbingProxy_Window: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var didCallMakeKeyAndVisible: Cuckoo.ToBeStubbedProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "didCallMakeKeyAndVisible")
        }
        
        
        func makeKeyAndVisible() -> Cuckoo.StubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub("makeKeyAndVisible()", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_Window: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        
        var didCallMakeKeyAndVisible: Cuckoo.VerifyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "didCallMakeKeyAndVisible", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
        @discardableResult
        func makeKeyAndVisible() -> Cuckoo.__DoNotUse<Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("makeKeyAndVisible()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class WindowStub: Window {
    
     override var didCallMakeKeyAndVisible: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    

    

    
    public override func makeKeyAndVisible()  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneRenderer/ViewControllerContainer.swift at 2017-09-16 23:52:51 +0000

//
//  ViewControllerContainer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation
import UIKit

class MockViewControllerContainer: ViewControllerContainer, Cuckoo.Mock {
    typealias MocksType = ViewControllerContainer
    typealias Stubbing = __StubbingProxy_ViewControllerContainer
    typealias Verification = __VerificationProxy_ViewControllerContainer
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: ViewControllerContainer?

    func spy(on victim: ViewControllerContainer) -> Self {
        observed = victim
        return self
    }

    
    // ["name": "rootViewController", "accesibility": "public", "@type": "InstanceVariable", "type": "UIViewController", "isReadOnly": true]
     var rootViewController: UIViewController {
        get {
            return cuckoo_manager.getter("rootViewController", original: observed.map { o in return { () -> UIViewController in o.rootViewController }})
        }
        
    }
    
    // ["name": "firstLevelNavigationControllers", "accesibility": "public", "@type": "InstanceVariable", "type": "[UINavigationController]", "isReadOnly": true]
     var firstLevelNavigationControllers: [UINavigationController] {
        get {
            return cuckoo_manager.getter("firstLevelNavigationControllers", original: observed.map { o in return { () -> [UINavigationController] in o.firstLevelNavigationControllers }})
        }
        
    }
    
    // ["name": "visibleNavigationController", "accesibility": "public", "@type": "InstanceVariable", "type": "UINavigationController", "isReadOnly": true]
     var visibleNavigationController: UINavigationController {
        get {
            return cuckoo_manager.getter("visibleNavigationController", original: observed.map { o in return { () -> UINavigationController in o.visibleNavigationController }})
        }
        
    }
    

    

    
    public func setSelectedViewController(_ selectedViewController: UIViewController)  {
        
        return cuckoo_manager.call("setSelectedViewController(_: UIViewController)",
            parameters: (selectedViewController),
            original: observed.map { o in
                return { (selectedViewController: UIViewController) in
                    o.setSelectedViewController(selectedViewController)
                }
            })
        
    }
    

    struct __StubbingProxy_ViewControllerContainer: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var rootViewController: Cuckoo.ToBeStubbedReadOnlyProperty<UIViewController> {
            return .init(manager: cuckoo_manager, name: "rootViewController")
        }
        
        var firstLevelNavigationControllers: Cuckoo.ToBeStubbedReadOnlyProperty<[UINavigationController]> {
            return .init(manager: cuckoo_manager, name: "firstLevelNavigationControllers")
        }
        
        var visibleNavigationController: Cuckoo.ToBeStubbedReadOnlyProperty<UINavigationController> {
            return .init(manager: cuckoo_manager, name: "visibleNavigationController")
        }
        
        
        func setSelectedViewController<M1: Cuckoo.Matchable>(_ selectedViewController: M1) -> Cuckoo.StubNoReturnFunction<(UIViewController)> where M1.MatchedType == UIViewController {
            let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: selectedViewController) { $0 }]
            return .init(stub: cuckoo_manager.createStub("setSelectedViewController(_: UIViewController)", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_ViewControllerContainer: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        
        var rootViewController: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
            return .init(manager: cuckoo_manager, name: "rootViewController", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var firstLevelNavigationControllers: Cuckoo.VerifyReadOnlyProperty<[UINavigationController]> {
            return .init(manager: cuckoo_manager, name: "firstLevelNavigationControllers", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var visibleNavigationController: Cuckoo.VerifyReadOnlyProperty<UINavigationController> {
            return .init(manager: cuckoo_manager, name: "visibleNavigationController", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
        @discardableResult
        func setSelectedViewController<M1: Cuckoo.Matchable>(_ selectedViewController: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIViewController {
            let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: selectedViewController) { $0 }]
            return cuckoo_manager.verify("setSelectedViewController(_: UIViewController)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class ViewControllerContainerStub: ViewControllerContainer {
    
     var rootViewController: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    
     var firstLevelNavigationControllers: [UINavigationController] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([UINavigationController]).self)
        }
        
    }
    
     var visibleNavigationController: UINavigationController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UINavigationController).self)
        }
        
    }
    

    

    
    public func setSelectedViewController(_ selectedViewController: UIViewController)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneRenderer/SceneRenderer.swift at 2017-09-16 23:52:51 +0000

//
//  SceneRenderer.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation
import UIKit

class MockSceneRenderer: SceneRenderer, Cuckoo.Mock {
    typealias MocksType = SceneRenderer
    typealias Stubbing = __StubbingProxy_SceneRenderer
    typealias Verification = __VerificationProxy_SceneRenderer
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: SceneRenderer?

    func spy(on victim: SceneRenderer) -> Self {
        observed = victim
        return self
    }

    
    // ["name": "viewControllerContainer", "accesibility": "", "@type": "InstanceVariable", "type": "ViewControllerContainer", "isReadOnly": false]
     override var viewControllerContainer: ViewControllerContainer {
        get {
            return cuckoo_manager.getter("viewControllerContainer", original: observed.map { o in return { () -> ViewControllerContainer in o.viewControllerContainer }})
        }
        
        set {
            cuckoo_manager.setter("viewControllerContainer", value: newValue, original: observed != nil ? { self.observed?.viewControllerContainer = $0 } : nil)
        }
        
    }
    
    // ["name": "rootViewController", "accesibility": "", "@type": "InstanceVariable", "type": "UIViewController", "isReadOnly": true]
     override var rootViewController: UIViewController {
        get {
            return cuckoo_manager.getter("rootViewController", original: observed.map { o in return { () -> UIViewController in o.rootViewController }})
        }
        
    }
    
    // ["name": "visibleNavigationController", "accesibility": "", "@type": "InstanceVariable", "type": "UINavigationController", "isReadOnly": true]
     override var visibleNavigationController: UINavigationController {
        get {
            return cuckoo_manager.getter("visibleNavigationController", original: observed.map { o in return { () -> UINavigationController in o.visibleNavigationController }})
        }
        
    }
    

    

    
     override func setSelectedViewController(_ selectedViewController: UIViewController)  {
        
        return cuckoo_manager.call("setSelectedViewController(_: UIViewController)",
            parameters: (selectedViewController),
            original: observed.map { o in
                return { (selectedViewController: UIViewController) in
                    o.setSelectedViewController(selectedViewController)
                }
            })
        
    }
    
     override func set(scenes: [Scene])  -> SceneOperation {
        
        return cuckoo_manager.call("set(scenes: [Scene]) -> SceneOperation",
            parameters: (scenes),
            original: observed.map { o in
                return { (scenes: [Scene]) -> SceneOperation in
                    o.set(scenes: scenes)
                }
            })
        
    }
    
     override func add(scenes: [Scene])  -> SceneOperation {
        
        return cuckoo_manager.call("add(scenes: [Scene]) -> SceneOperation",
            parameters: (scenes),
            original: observed.map { o in
                return { (scenes: [Scene]) -> SceneOperation in
                    o.add(scenes: scenes)
                }
            })
        
    }
    
     override func pop(animated: Bool)  -> SceneOperation {
        
        return cuckoo_manager.call("pop(animated: Bool) -> SceneOperation",
            parameters: (animated),
            original: observed.map { o in
                return { (animated: Bool) -> SceneOperation in
                    o.pop(animated: animated)
                }
            })
        
    }
    
     override func popToRoot(animated: Bool)  -> SceneOperation {
        
        return cuckoo_manager.call("popToRoot(animated: Bool) -> SceneOperation",
            parameters: (animated),
            original: observed.map { o in
                return { (animated: Bool) -> SceneOperation in
                    o.popToRoot(animated: animated)
                }
            })
        
    }
    
     override func dismiss(animated: Bool)  -> SceneOperation {
        
        return cuckoo_manager.call("dismiss(animated: Bool) -> SceneOperation",
            parameters: (animated),
            original: observed.map { o in
                return { (animated: Bool) -> SceneOperation in
                    o.dismiss(animated: animated)
                }
            })
        
    }
    
     override func dismiss(scene: Scene, animated: Bool)  -> SceneOperation {
        
        return cuckoo_manager.call("dismiss(scene: Scene, animated: Bool) -> SceneOperation",
            parameters: (scene, animated),
            original: observed.map { o in
                return { (scene: Scene, animated: Bool) -> SceneOperation in
                    o.dismiss(scene: scene, animated: animated)
                }
            })
        
    }
    
     override func install(scene: Scene)  -> SceneOperation {
        
        return cuckoo_manager.call("install(scene: Scene) -> SceneOperation",
            parameters: (scene),
            original: observed.map { o in
                return { (scene: Scene) -> SceneOperation in
                    o.install(scene: scene)
                }
            })
        
    }
    
     override func dismissAll(animated: Bool)  -> SceneOperation {
        
        return cuckoo_manager.call("dismissAll(animated: Bool) -> SceneOperation",
            parameters: (animated),
            original: observed.map { o in
                return { (animated: Bool) -> SceneOperation in
                    o.dismissAll(animated: animated)
                }
            })
        
    }
    
     override func recycle(scenes: [Scene])  -> SceneOperation {
        
        return cuckoo_manager.call("recycle(scenes: [Scene]) -> SceneOperation",
            parameters: (scenes),
            original: observed.map { o in
                return { (scenes: [Scene]) -> SceneOperation in
                    o.recycle(scenes: scenes)
                }
            })
        
    }
    
     override func transition(_ transition: Transition, to scene: Scene)  -> SceneOperation {
        
        return cuckoo_manager.call("transition(_: Transition, to: Scene) -> SceneOperation",
            parameters: (transition, scene),
            original: observed.map { o in
                return { (transition: Transition, scene: Scene) -> SceneOperation in
                    o.transition(transition, to: scene)
                }
            })
        
    }
    

    struct __StubbingProxy_SceneRenderer: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var viewControllerContainer: Cuckoo.ToBeStubbedProperty<ViewControllerContainer> {
            return .init(manager: cuckoo_manager, name: "viewControllerContainer")
        }
        
        var rootViewController: Cuckoo.ToBeStubbedReadOnlyProperty<UIViewController> {
            return .init(manager: cuckoo_manager, name: "rootViewController")
        }
        
        var visibleNavigationController: Cuckoo.ToBeStubbedReadOnlyProperty<UINavigationController> {
            return .init(manager: cuckoo_manager, name: "visibleNavigationController")
        }
        
        
        func setSelectedViewController<M1: Cuckoo.Matchable>(_ selectedViewController: M1) -> Cuckoo.StubNoReturnFunction<(UIViewController)> where M1.MatchedType == UIViewController {
            let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: selectedViewController) { $0 }]
            return .init(stub: cuckoo_manager.createStub("setSelectedViewController(_: UIViewController)", parameterMatchers: matchers))
        }
        
        func set<M1: Cuckoo.Matchable>(scenes: M1) -> Cuckoo.StubFunction<([Scene]), SceneOperation> where M1.MatchedType == [Scene] {
            let matchers: [Cuckoo.ParameterMatcher<([Scene])>] = [wrap(matchable: scenes) { $0 }]
            return .init(stub: cuckoo_manager.createStub("set(scenes: [Scene]) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func add<M1: Cuckoo.Matchable>(scenes: M1) -> Cuckoo.StubFunction<([Scene]), SceneOperation> where M1.MatchedType == [Scene] {
            let matchers: [Cuckoo.ParameterMatcher<([Scene])>] = [wrap(matchable: scenes) { $0 }]
            return .init(stub: cuckoo_manager.createStub("add(scenes: [Scene]) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func pop<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.StubFunction<(Bool), SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return .init(stub: cuckoo_manager.createStub("pop(animated: Bool) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func popToRoot<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.StubFunction<(Bool), SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return .init(stub: cuckoo_manager.createStub("popToRoot(animated: Bool) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func dismiss<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.StubFunction<(Bool), SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return .init(stub: cuckoo_manager.createStub("dismiss(animated: Bool) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func dismiss<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(scene: M1, animated: M2) -> Cuckoo.StubFunction<(Scene, Bool), SceneOperation> where M1.MatchedType == Scene, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Scene, Bool)>] = [wrap(matchable: scene) { $0.0 }, wrap(matchable: animated) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub("dismiss(scene: Scene, animated: Bool) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func install<M1: Cuckoo.Matchable>(scene: M1) -> Cuckoo.StubFunction<(Scene), SceneOperation> where M1.MatchedType == Scene {
            let matchers: [Cuckoo.ParameterMatcher<(Scene)>] = [wrap(matchable: scene) { $0 }]
            return .init(stub: cuckoo_manager.createStub("install(scene: Scene) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func dismissAll<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.StubFunction<(Bool), SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return .init(stub: cuckoo_manager.createStub("dismissAll(animated: Bool) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func recycle<M1: Cuckoo.Matchable>(scenes: M1) -> Cuckoo.StubFunction<([Scene]), SceneOperation> where M1.MatchedType == [Scene] {
            let matchers: [Cuckoo.ParameterMatcher<([Scene])>] = [wrap(matchable: scenes) { $0 }]
            return .init(stub: cuckoo_manager.createStub("recycle(scenes: [Scene]) -> SceneOperation", parameterMatchers: matchers))
        }
        
        func transition<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ transition: M1, to scene: M2) -> Cuckoo.StubFunction<(Transition, Scene), SceneOperation> where M1.MatchedType == Transition, M2.MatchedType == Scene {
            let matchers: [Cuckoo.ParameterMatcher<(Transition, Scene)>] = [wrap(matchable: transition) { $0.0 }, wrap(matchable: scene) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub("transition(_: Transition, to: Scene) -> SceneOperation", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_SceneRenderer: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        
        var viewControllerContainer: Cuckoo.VerifyProperty<ViewControllerContainer> {
            return .init(manager: cuckoo_manager, name: "viewControllerContainer", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var rootViewController: Cuckoo.VerifyReadOnlyProperty<UIViewController> {
            return .init(manager: cuckoo_manager, name: "rootViewController", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var visibleNavigationController: Cuckoo.VerifyReadOnlyProperty<UINavigationController> {
            return .init(manager: cuckoo_manager, name: "visibleNavigationController", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
        @discardableResult
        func setSelectedViewController<M1: Cuckoo.Matchable>(_ selectedViewController: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == UIViewController {
            let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: selectedViewController) { $0 }]
            return cuckoo_manager.verify("setSelectedViewController(_: UIViewController)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func set<M1: Cuckoo.Matchable>(scenes: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == [Scene] {
            let matchers: [Cuckoo.ParameterMatcher<([Scene])>] = [wrap(matchable: scenes) { $0 }]
            return cuckoo_manager.verify("set(scenes: [Scene]) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func add<M1: Cuckoo.Matchable>(scenes: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == [Scene] {
            let matchers: [Cuckoo.ParameterMatcher<([Scene])>] = [wrap(matchable: scenes) { $0 }]
            return cuckoo_manager.verify("add(scenes: [Scene]) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func pop<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return cuckoo_manager.verify("pop(animated: Bool) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func popToRoot<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return cuckoo_manager.verify("popToRoot(animated: Bool) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func dismiss<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return cuckoo_manager.verify("dismiss(animated: Bool) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func dismiss<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(scene: M1, animated: M2) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Scene, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Scene, Bool)>] = [wrap(matchable: scene) { $0.0 }, wrap(matchable: animated) { $0.1 }]
            return cuckoo_manager.verify("dismiss(scene: Scene, animated: Bool) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func install<M1: Cuckoo.Matchable>(scene: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Scene {
            let matchers: [Cuckoo.ParameterMatcher<(Scene)>] = [wrap(matchable: scene) { $0 }]
            return cuckoo_manager.verify("install(scene: Scene) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func dismissAll<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
            return cuckoo_manager.verify("dismissAll(animated: Bool) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func recycle<M1: Cuckoo.Matchable>(scenes: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == [Scene] {
            let matchers: [Cuckoo.ParameterMatcher<([Scene])>] = [wrap(matchable: scenes) { $0 }]
            return cuckoo_manager.verify("recycle(scenes: [Scene]) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func transition<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ transition: M1, to scene: M2) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == Transition, M2.MatchedType == Scene {
            let matchers: [Cuckoo.ParameterMatcher<(Transition, Scene)>] = [wrap(matchable: transition) { $0.0 }, wrap(matchable: scene) { $0.1 }]
            return cuckoo_manager.verify("transition(_: Transition, to: Scene) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class SceneRendererStub: SceneRenderer {
    
     override var viewControllerContainer: ViewControllerContainer {
        get {
            return DefaultValueRegistry.defaultValue(for: (ViewControllerContainer).self)
        }
        
        set { }
        
    }
    
     override var rootViewController: UIViewController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
        }
        
    }
    
     override var visibleNavigationController: UINavigationController {
        get {
            return DefaultValueRegistry.defaultValue(for: (UINavigationController).self)
        }
        
    }
    

    

    
     override func setSelectedViewController(_ selectedViewController: UIViewController)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func set(scenes: [Scene])  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func add(scenes: [Scene])  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func pop(animated: Bool)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func popToRoot(animated: Bool)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func dismiss(animated: Bool)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func dismiss(scene: Scene, animated: Bool)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func install(scene: Scene)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func dismissAll(animated: Bool)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func recycle(scenes: [Scene])  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
     override func transition(_ transition: Transition, to scene: Scene)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneMatcher/SceneMatcher.swift at 2017-09-16 23:52:51 +0000

//
//  SceneMatcher.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 2/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation

class MockSceneProvider: SceneProvider, Cuckoo.Mock {
    typealias MocksType = SceneProvider
    typealias Stubbing = __StubbingProxy_SceneProvider
    typealias Verification = __VerificationProxy_SceneProvider
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: SceneProvider?

    func spy(on victim: SceneProvider) -> Self {
        observed = victim
        return self
    }

    

    

    

    struct __StubbingProxy_SceneProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
    }


    struct __VerificationProxy_SceneProvider: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
    }


}

 class SceneProviderStub: SceneProvider {
    

    

    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneOperation/SceneOperation.swift at 2017-09-16 23:52:51 +0000

//
//  SceneOperation.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 8/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation

class MockSceneOperation: SceneOperation, Cuckoo.Mock {
    typealias MocksType = SceneOperation
    typealias Stubbing = __StubbingProxy_SceneOperation
    typealias Verification = __VerificationProxy_SceneOperation
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: SceneOperation?

    func spy(on victim: SceneOperation) -> Self {
        observed = victim
        return self
    }

    

    

    
     func execute(with completion: CompletionBlock?)  {
        
        return cuckoo_manager.call("execute(with: CompletionBlock?)",
            parameters: (completion),
            original: observed.map { o in
                return { (completion: CompletionBlock?) in
                    o.execute(with: completion)
                }
            })
        
    }
    
     func then(_ operation: SceneOperation)  -> SceneOperation {
        
        return cuckoo_manager.call("then(_: SceneOperation) -> SceneOperation",
            parameters: (operation),
            original: observed.map { o in
                return { (operation: SceneOperation) -> SceneOperation in
                    o.then(operation)
                }
            })
        
    }
    

    struct __StubbingProxy_SceneOperation: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func execute<M1: Cuckoo.Matchable>(with completion: M1) -> Cuckoo.StubNoReturnFunction<(CompletionBlock?)> where M1.MatchedType == CompletionBlock? {
            let matchers: [Cuckoo.ParameterMatcher<(CompletionBlock?)>] = [wrap(matchable: completion) { $0 }]
            return .init(stub: cuckoo_manager.createStub("execute(with: CompletionBlock?)", parameterMatchers: matchers))
        }
        
        func then<M1: Cuckoo.Matchable>(_ operation: M1) -> Cuckoo.StubFunction<(SceneOperation), SceneOperation> where M1.MatchedType == SceneOperation {
            let matchers: [Cuckoo.ParameterMatcher<(SceneOperation)>] = [wrap(matchable: operation) { $0 }]
            return .init(stub: cuckoo_manager.createStub("then(_: SceneOperation) -> SceneOperation", parameterMatchers: matchers))
        }
        
    }


    struct __VerificationProxy_SceneOperation: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        

        
        @discardableResult
        func execute<M1: Cuckoo.Matchable>(with completion: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == CompletionBlock? {
            let matchers: [Cuckoo.ParameterMatcher<(CompletionBlock?)>] = [wrap(matchable: completion) { $0 }]
            return cuckoo_manager.verify("execute(with: CompletionBlock?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func then<M1: Cuckoo.Matchable>(_ operation: M1) -> Cuckoo.__DoNotUse<SceneOperation> where M1.MatchedType == SceneOperation {
            let matchers: [Cuckoo.ParameterMatcher<(SceneOperation)>] = [wrap(matchable: operation) { $0 }]
            return cuckoo_manager.verify("then(_: SceneOperation) -> SceneOperation", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class SceneOperationStub: SceneOperation {
    

    

    
     func execute(with completion: CompletionBlock?)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     func then(_ operation: SceneOperation)  -> SceneOperation {
        return DefaultValueRegistry.defaultValue(for: SceneOperation.self)
    }
    
}



