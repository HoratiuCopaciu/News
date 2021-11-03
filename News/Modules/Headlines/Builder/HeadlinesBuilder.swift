//
//  HeadlinesBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain
import Networking

protocol HeadlinesDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
}

final class HeadlinesComponent: Component<HeadlinesDependency> {
    var headlinesProvider: HeadlinesProviderProtocol {
        shared({
            HeadlinesProvider(client: dependency.networkClient)
        })
    }
}

extension HeadlinesComponent: ArticleDependency {
    var networkClient: NetworkClientProtocol {
        dependency.networkClient
    }
}

protocol HeadlinesBuildable: Buildable {
    func build(navigationController: UINavigationController,
               country: Country) -> UIViewController
}

final class HeadlinesBuilder: Builder<HeadlinesDependency>, HeadlinesBuildable {
    func build(navigationController: UINavigationController,
               country: Country) -> UIViewController {
        let component = HeadlinesComponent(dependency: dependency)
        let articleBuilder = ArticleBuilder(dependency: component)
        let viewController = HeadlinesViewController()
        let interactor = HeadlinesInteractor(headlinesProvider: component.headlinesProvider,
                                             country: country)
        let router = HeadlinesRouter(navigationController: navigationController,
                                     articleBuilder: articleBuilder)
        let presenter = HeadlinesPresenter(view: viewController,
                                           interactor: interactor,
                                           router: router)
        
        interactor.output = presenter
        router.output = presenter
        viewController.output = presenter
        
        return viewController
    }
}
