//
//  Component.swift
//  
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import Foundation

open class Component<DependencyType>: Dependency {

    public let dependency: DependencyType
    private var sharedInstances = [String: Any]()
    private let lock = NSRecursiveLock()

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }

    public final func shared<T>(name: String = #function, _ factory: () -> T) -> T {
        lock.lock()
        defer {
            lock.unlock()
        }

        if let instance = sharedInstances[name] as? T {
            return instance
        }

        let instance = factory()
        sharedInstances[name] = instance

        return instance
    }
}

open class EmptyComponent: EmptyDependency {
    public init() {}
}
