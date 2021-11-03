//
//  MainMenuRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain

protocol MainMenuRouterInput {
    func showHeadlines(for country: Country)
    func showCountrySelection()
}

protocol MainMenuRouterOutput: AnyObject {
    func didSelectCountry(_ country: Country)
}

final class MainMenuRouter {
    weak var output: MainMenuRouterOutput?
    private unowned var tabBarController: UITabBarController
    private let countrySelectionBuilder: CountrySelectionBuildable
    private let headlinesBuilder: HeadlinesBuildable
    private let categoriesBuilder: CategoriesBuildable
    
    init(tabBarController: UITabBarController,
         countrySelectionBuilder: CountrySelectionBuildable,
         headlinesBuilder: HeadlinesBuildable,
         categoriesBuilder: CategoriesBuildable) {
        self.tabBarController = tabBarController
        self.countrySelectionBuilder = countrySelectionBuilder
        self.headlinesBuilder = headlinesBuilder
        self.categoriesBuilder = categoriesBuilder
    }
    
    private func getHeadlinesNavigationController(for country: Country) -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: "Headlines", image: nil, selectedImage: nil)
        let viewController = headlinesBuilder.build(navigationController: navigationController,
                                                    country: country)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    private func getCategoriesNavigationController() -> UIViewController {
        let navigationController = UINavigationController()
        let viewController = categoriesBuilder.build(navigationController: navigationController)
        navigationController.tabBarItem = .init(title: "Categories", image: nil, selectedImage: nil)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}

// MARK: - MainMenuRouterInput

extension MainMenuRouter: MainMenuRouterInput {
    func showHeadlines(for country: Country) {
        tabBarController.viewControllers = [getHeadlinesNavigationController(for: country),
                                            getCategoriesNavigationController()]
    }
    
    func showCountrySelection() {
        let viewController = countrySelectionBuilder.build(handler: { [weak self] country in
            self?.tabBarController.dismiss(animated: true,
                                           completion: {
                self?.output?.didSelectCountry(country)
            })
        })
        let navigationController = UINavigationController(rootViewController: viewController)
        tabBarController.present(navigationController, animated: true, completion: nil)
    }
}
