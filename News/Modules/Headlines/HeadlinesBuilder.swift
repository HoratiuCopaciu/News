//
//  HeadlinesBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import Networking
import NewsDomain

protocol HeadlinesDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
}

final class HeadlinesComponent: Component<HeadlinesDependency> {
    fileprivate var headlinesProvider: HeadlinesProviderProtocol {
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

// MARK: - Builder

protocol HeadlinesBuildable: Buildable {
    func build(withCountry country: Country) -> HeadlinesRouting
}

final class HeadlinesBuilder: Builder<HeadlinesDependency>, HeadlinesBuildable {

    override init(dependency: HeadlinesDependency) {
        super.init(dependency: dependency)
    }

    func build(withCountry country: Country) -> HeadlinesRouting {
        let component = HeadlinesComponent(dependency: dependency)
        let articleBuilder = ArticleBuilder(dependency: component)
        let viewController = HeadlinesViewController()
        let interactor = HeadlinesInteractor(presenter: viewController,
                                             headlinesProvider: component.headlinesProvider,
                                             country: country)
        return HeadlinesRouter(interactor: interactor,
                               viewController: viewController,
                               articleBuilder: articleBuilder)
    }
}
