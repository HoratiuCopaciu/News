//
//  AppComponent.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import NewsDomain

public final class AppComponent: Component<EmptyDependency> {
    public init() {
        super.init(dependency: EmptyComponent())
    }
}

extension AppComponent: LaunchDependency {}
