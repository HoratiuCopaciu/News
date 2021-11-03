//
//  CategoriesBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain
import Networking

protocol CategoriesDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
}

final class CategoriesComponent: Component<CategoriesDependency> {
    var categoriesProvider: CategoriesProviderProtocol {
        shared({
            CategoriesProvider(client: dependency.networkClient)
        })
    }
}

extension CategoriesComponent: CategoryArticlesDependency {
    var networkClient: NetworkClientProtocol {
        dependency.networkClient
    }
}

protocol CategoriesBuildable: Buildable {
    func build(navigationController: UINavigationController) -> UIViewController
}

final class CategoriesBuilder: Builder<CategoriesDependency>, CategoriesBuildable {
    func build(navigationController: UINavigationController) -> UIViewController {
        let component = CategoriesComponent(dependency: dependency)
        let categoryArticlesBuilder = CategoryArticlesBuilder(dependency: component)
        let viewController = CategoriesViewController()
        let interactor = CategoriesInteractor(categoriesProvider: component.categoriesProvider)
        let router = CategoriesRouter(navigationController: navigationController,
                                      categoryArticlesBuilder: categoryArticlesBuilder)
        let presenter = CategoriesPresenter(view: viewController,
                                            interactor: interactor,
                                            router: router)
        
        interactor.output = presenter
        router.output = presenter
        viewController.output = presenter
        
        return viewController
    }
}
