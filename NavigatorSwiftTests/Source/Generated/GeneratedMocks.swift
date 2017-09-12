// MARK: - Mocks generated from file: NavigatorSwift/Source/Domain/Scene.swift at 2017-09-12 19:37:48 +0000

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




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneHandler/SceneHandler.swift at 2017-09-12 19:37:48 +0000

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




// MARK: - Mocks generated from file: NavigatorSwiftTests/Source/Utils/ViewController.swift at 2017-09-12 19:37:48 +0000

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

    
    // ["name": "collectionView", "accesibility": "", "@type": "InstanceVariable", "type": "UICollectionView!", "isReadOnly": false]
     override var collectionView: UICollectionView! {
        get {
            return cuckoo_manager.getter("collectionView", original: observed.map { o in return { () -> UICollectionView! in o.collectionView }})
        }
        
        set {
            cuckoo_manager.setter("collectionView", value: newValue, original: observed != nil ? { self.observed?.collectionView = $0 } : nil)
        }
        
    }
    

    

    

    struct __StubbingProxy_ViewController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var collectionView: Cuckoo.ToBeStubbedProperty<UICollectionView?> {
            return .init(manager: cuckoo_manager, name: "collectionView")
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

        
        var collectionView: Cuckoo.VerifyProperty<UICollectionView?> {
            return .init(manager: cuckoo_manager, name: "collectionView", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
    }


}

 class ViewControllerStub: ViewController {
    
     override var collectionView: UICollectionView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UICollectionView!).self)
        }
        
        set { }
        
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

    
    // ["name": "rootViewController", "accesibility": "public", "@type": "InstanceVariable", "type": "UIViewController?", "isReadOnly": false]
     override var rootViewController: UIViewController? {
        get {
            return cuckoo_manager.getter("rootViewController", original: observed.map { o in return { () -> UIViewController? in o.rootViewController }})
        }
        
        set {
            cuckoo_manager.setter("rootViewController", value: newValue, original: observed != nil ? { self.observed?.rootViewController = $0 } : nil)
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
        
        var rootViewController: Cuckoo.ToBeStubbedProperty<UIViewController?> {
            return .init(manager: cuckoo_manager, name: "rootViewController")
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

        
        var rootViewController: Cuckoo.VerifyProperty<UIViewController?> {
            return .init(manager: cuckoo_manager, name: "rootViewController", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
        @discardableResult
        func makeKeyAndVisible() -> Cuckoo.__DoNotUse<Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("makeKeyAndVisible()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class WindowStub: Window {
    
     override var rootViewController: UIViewController? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIViewController?).self)
        }
        
        set { }
        
    }
    

    

    
    public override func makeKeyAndVisible()  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneRenderer/ViewControllerContainer.swift at 2017-09-12 19:37:48 +0000

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




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneRenderer/SceneRenderer.swift at 2017-09-12 19:37:48 +0000

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
    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneMatcher/SceneMatcher.swift at 2017-09-12 19:37:48 +0000

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




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneOperation/SceneOperation.swift at 2017-09-12 19:37:48 +0000

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



