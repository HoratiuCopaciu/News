//
//  CategoriesRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain

protocol CategoriesRouterInput {
    func showCategory(_ category: NewsCategory)
}

protocol CategoriesRouterOutput: AnyObject {
}

final class CategoriesRouter {
    weak var output: CategoriesRouterOutput?
    private unowned var navigationController: UINavigationController
    private let categoryArticlesBuilder: CategoryArticlesBuildable
    
    init(navigationController: UINavigationController,
         categoryArticlesBuilder: CategoryArticlesBuildable) {
        self.navigationController = navigationController
        self.categoryArticlesBuilder = categoryArticlesBuilder
    }
}

// MARK: - CategoriesRouterInput

extension CategoriesRouter: CategoriesRouterInput {
    func showCategory(_ category: NewsCategory) {
        let viewController = categoryArticlesBuilder.build(category: category)
        navigationController.pushViewController(viewController, animated: true)
    }
}
