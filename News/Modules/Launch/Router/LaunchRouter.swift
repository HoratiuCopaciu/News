//
//  LaunchRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LaunchRouterInput {
}

protocol LaunchRouterOutput: AnyObject {
}

final class LaunchRouter {
    weak var output: LaunchRouterOutput?
    
    private let mainMenuBuilder: MainMenuBuildable

    init(mainMenuBuilder: MainMenuBuildable) {
        self.mainMenuBuilder = mainMenuBuilder
    }
}

// MARK: - LaunchRouterInput

extension LaunchRouter: LaunchRouterInput {
}

extension LaunchRouter: LaunchRoutingInput {
    func launch(from window: UIWindow?) {
        let (viewController, input) = mainMenuBuilder.build()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        input.start()
    }
}
