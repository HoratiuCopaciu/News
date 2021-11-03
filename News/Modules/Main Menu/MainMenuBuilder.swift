//
//  MainMenuBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 05.11.2021.
//

import RIBs
import UIKit
import Networking
import NewsDomain

protocol MainMenuDependency: Dependency {
    var client: NetworkClientProtocol { get }
}

final class MainMenuComponent: Component<MainMenuDependency> {
    fileprivate var storage: CountryStorageProtocol {
        UserDefaults.standard
    }
}

extension MainMenuComponent: CountrySelectionDependency {
    var countryProvider: CountryProviderProtocol {
        shared({
            CountryProvider(storage: storage)
        })
    }
}

extension MainMenuComponent: HeadlinesDependency {
    var client: NetworkClientProtocol {
        dependency.client
    }
    
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

extension MainMenuComponent: PagedArticlesDependency {
    var headlinesProvider: HeadlinesProviderProtocol {
        shared({
            HeadlinesProvider(client: networkClient)
        })
    }
}

// MARK: - Builder

protocol MainMenuBuildable: Buildable {
    func build(for country: Country) -> MainMenuRouting
}

final class MainMenuBuilder: Builder<MainMenuDependency>, MainMenuBuildable {

    override init(dependency: MainMenuDependency) {
        super.init(dependency: dependency)
    }

    func build(for country: Country) -> MainMenuRouting {
        let component = MainMenuComponent(dependency: dependency)
        let headlinesBuilder = HeadlinesBuilder(dependency: component)
        let pagedArticlesBuilder = PagedArticlesBuilder(dependency: component)
        let countrySelectionBuilder = CountrySelectionBuilder(dependency: component)
        let viewController = MainMenuViewController()
        let interactor = MainMenuInteractor(presenter: viewController,
                                            country: country)
        return MainMenuRouter(interactor: interactor,
                              viewController: viewController,
                              countrySelectionBuilder: countrySelectionBuilder,
                              headlinesBuilder: headlinesBuilder,
                              pagedArticlesBuilder: pagedArticlesBuilder)
    }
}
