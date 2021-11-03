//
//  Builder.swift
//  
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import Foundation

public protocol Buildable: AnyObject {}

open class Builder<DependencyType>: Buildable {
    
    public let dependency: DependencyType
    
    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
}
