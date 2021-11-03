//
//  LaunchBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain

protocol LaunchDependency: Dependency {}

final class LaunchComponent: Component<LaunchDependency> {
    
}

extension LaunchComponent: MainMenuDependency {}

public protocol LaunchInput {
    
}

public protocol LaunchRoutingInput {
    func launch(from window: UIWindow?)
}


protocol LaunchBuildable: Buildable {
    func build() -> (LaunchInput, LaunchRoutingInput)
}

final class LaunchBuilder: Builder<LaunchDependency>, LaunchBuildable {
    func build() -> (LaunchInput, LaunchRoutingInput) {
        let component = LaunchComponent(dependency: dependency)
        let mainMenuBuilder = MainMenuBuilder(dependency: component)
        let interactor = LaunchInteractor()
        let router = LaunchRouter(mainMenuBuilder: mainMenuBuilder)
        let presenter = LaunchPresenter(interactor: interactor,
                                        router: router)

        interactor.output = presenter
        router.output = presenter

        return (presenter, router)
    }
}
