//
//  CategoriesBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs

protocol CategoriesDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CategoriesComponent: Component<CategoriesDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CategoriesBuildable: Buildable {
    func build() -> CategoriesRouting
}

final class CategoriesBuilder: Builder<CategoriesDependency>, CategoriesBuildable {

    override init(dependency: CategoriesDependency) {
        super.init(dependency: dependency)
    }

    func build() -> CategoriesRouting {
        let component = CategoriesComponent(dependency: dependency)
        let viewController = CategoriesViewController()
        let interactor = CategoriesInteractor(presenter: viewController)

        return CategoriesRouter(interactor: interactor, viewController: viewController)
    }
}
