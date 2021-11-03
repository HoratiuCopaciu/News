//
//  CategoryArticlesBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain
import Networking

protocol CategoryArticlesDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
    var categoriesProvider: CategoriesProviderProtocol { get }
}

final class CategoryArticlesComponent: Component<CategoryArticlesDependency> {
    var categoriesProvider: CategoriesProviderProtocol {
        dependency.categoriesProvider
    }
}

protocol CategoryArticlesBuildable: Buildable {
    func build(category: NewsCategory) -> UIViewController
}

final class CategoryArticlesBuilder: Builder<CategoryArticlesDependency>, CategoryArticlesBuildable {
    func build(category: NewsCategory) -> UIViewController {
        let component = CategoryArticlesComponent(dependency: dependency)
        let viewController = CategoryArticlesViewController()
        let interactor = CategoryArticlesInteractor(categoriesProvider: component.categoriesProvider,
                                                    category: category)
        let presenter = CategoryArticlesPresenter(view: viewController,
                                                  interactor: interactor)
        
        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
