//
//  CountrySelectionBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs

protocol CountrySelectionDependency: Dependency {
    var countryProvider: CountryProviderProtocol { get }
}

final class CountrySelectionComponent: Component<CountrySelectionDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CountrySelectionBuildable: Buildable {
    func build(withListener listener: CountrySelectionListener) -> CountrySelectionRouting
}

final class CountrySelectionBuilder: Builder<CountrySelectionDependency>, CountrySelectionBuildable {

    override init(dependency: CountrySelectionDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CountrySelectionListener) -> CountrySelectionRouting {
        let viewController = CountrySelectionViewController()
        let interactor = CountrySelectionInteractor(presenter: viewController,
                                                    countryProvider: dependency.countryProvider)
        interactor.listener = listener
        return CountrySelectionRouter(interactor: interactor,
                                      viewController: viewController)
    }
}
