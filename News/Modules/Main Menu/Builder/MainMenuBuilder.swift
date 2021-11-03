//
//  MainMenuBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain
import Networking
import UIKit

protocol MainMenuDependency: Dependency {}

final class MainMenuComponent: Component<MainMenuDependency> {
    var countryProvider: CountryProviderProtocol {
        shared({
            CountryProvider(storage: storage)
        })
    }
    
    var storage: CountryStorageProtocol {
        UserDefaults.standard
    }
}

extension MainMenuComponent: CountrySelectionDependency {}
extension MainMenuComponent: HeadlinesDependency {
    var networkClient: NetworkClientProtocol {
        shared({
            NetworkClient(session: .shared)
        })
    }
    
    var imageLoader: ImageLoaderProtocol {
        shared({
            ImageLoader(networkClient: networkClient)
        })
    }
}

extension MainMenuComponent: CategoriesDependency {}

protocol MainMenuInput {
    func start()
}

protocol MainMenuBuildable: Buildable {
    func build() -> (UIViewController, MainMenuInput)
}

final class MainMenuBuilder: Builder<MainMenuDependency>, MainMenuBuildable {
    func build() -> (UIViewController, MainMenuInput) {
        let component = MainMenuComponent(dependency: dependency)
        let countrySelectionBuilder = CountrySelectionBuilder(dependency: component)
        let headlinesBuilder = HeadlinesBuilder(dependency: component)
        let categoriesBuilder = CategoriesBuilder(dependency: component)
        let viewController = MainMenuViewController()
        let interactor = MainMenuInteractor(countryProvider: component.countryProvider)
        let router = MainMenuRouter(tabBarController: viewController,
                                    countrySelectionBuilder: countrySelectionBuilder,
                                    headlinesBuilder: headlinesBuilder,
                                    categoriesBuilder: categoriesBuilder)
        let presenter = MainMenuPresenter(view: viewController,
                                          interactor: interactor,
                                          router: router)

        interactor.output = presenter
        router.output = presenter
        viewController.output = presenter

        return (viewController, presenter)
    }
}
