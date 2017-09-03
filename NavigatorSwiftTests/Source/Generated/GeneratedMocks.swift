// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneHandler/SceneHandler.swift at 2017-09-03 15:50:58 +0000

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




// MARK: - Mocks generated from file: NavigatorSwift/Source/NavigationRequest/NavigationRequestComponent.swift at 2017-09-03 15:50:58 +0000

//
//  NavigationRequestComponent.swift
//  NavigatorSwift
//
//  Created by Jose Maria Puerta on 1/9/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Cuckoo
@testable import NavigatorSwift

import Foundation

class MockNavigationRequestComponent: NavigationRequestComponent, Cuckoo.Mock {
    typealias MocksType = NavigationRequestComponent
    typealias Stubbing = __StubbingProxy_NavigationRequestComponent
    typealias Verification = __VerificationProxy_NavigationRequestComponent
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: NavigationRequestComponent?

    func spy(on victim: NavigationRequestComponent) -> Self {
        observed = victim
        return self
    }

    
    // ["name": "pathComponent", "accesibility": "public", "@type": "InstanceVariable", "type": "String", "isReadOnly": true]
     override var pathComponent: String {
        get {
            return cuckoo_manager.getter("pathComponent", original: observed.map { o in return { () -> String in o.pathComponent }})
        }
        
    }
    

    

    

    struct __StubbingProxy_NavigationRequestComponent: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var pathComponent: Cuckoo.ToBeStubbedReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "pathComponent")
        }
        
        
    }


    struct __VerificationProxy_NavigationRequestComponent: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        
        var pathComponent: Cuckoo.VerifyReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "pathComponent", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        

        
    }


}

 class NavigationRequestComponentStub: NavigationRequestComponent {
    
     override var pathComponent: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
}




// MARK: - Mocks generated from file: NavigatorSwiftTests/Source/Utils/ViewController.swift at 2017-09-03 15:50:58 +0000

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

    

    

    

    struct __StubbingProxy_ViewController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
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

        

        
    }


}

 class ViewControllerStub: ViewController {
    

    

    
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

        

        
        @discardableResult
        func makeKeyAndVisible() -> Cuckoo.__DoNotUse<Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("makeKeyAndVisible()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }


}

 class WindowStub: Window {
    

    

    
    public override func makeKeyAndVisible()  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/SceneMatcher/SceneMatcher.swift at 2017-09-03 15:50:58 +0000

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

class MockSceneMatcher: SceneMatcher, Cuckoo.Mock {
    typealias MocksType = SceneMatcher
    typealias Stubbing = __StubbingProxy_SceneMatcher
    typealias Verification = __VerificationProxy_SceneMatcher
    let cuckoo_manager = Cuckoo.MockManager()

    private var observed: SceneMatcher?

    func spy(on victim: SceneMatcher) -> Self {
        observed = victim
        return self
    }

    

    

    

    struct __StubbingProxy_SceneMatcher: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
    }


    struct __VerificationProxy_SceneMatcher: Cuckoo.VerificationProxy {
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

 class SceneMatcherStub: SceneMatcher {
    

    

    
}




// MARK: - Mocks generated from file: NavigatorSwift/Source/Domain/Scene.swift at 2017-09-03 15:50:58 +0000

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



