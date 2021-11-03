//
//  RootBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import Networking
import Foundation

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    internal var countryProvider: CountryProviderProtocol {
        shared({
            CountryProvider(storage: storage)
        })
    }
    
    fileprivate var storage: CountryStorageProtocol {
        UserDefaults.standard
    }
}

extension RootComponent: MainMenuDependency {
    var client: NetworkClientProtocol {
        shared({
            NetworkClient(session: .shared)
        })
    }
}
extension RootComponent: CountrySelectionDependency {}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let mainMenuBuilder = MainMenuBuilder(dependency: component)
        let countrySelectionBuilder = CountrySelectionBuilder(dependency: component)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController,
                                        countryProvider: component.countryProvider)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          mainMenuBuilder: mainMenuBuilder,
                          countrySelectionBuilder: countrySelectionBuilder)
    }
}
