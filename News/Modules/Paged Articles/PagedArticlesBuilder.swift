//
//  PagedArticlesBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 07.11.2021.
//

import RIBs
import NewsDomain
import Networking

protocol PagedArticlesDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
    var headlinesProvider: HeadlinesProviderProtocol { get }
}

final class PagedArticlesComponent: Component<PagedArticlesDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

extension PagedArticlesComponent: ArticleDependency {
    var networkClient: NetworkClientProtocol {
        dependency.networkClient
    }
}

// MARK: - Builder

protocol PagedArticlesBuildable: Buildable {
    func build(withCountry country: Country) -> PagedArticlesRouting
}

final class PagedArticlesBuilder: Builder<PagedArticlesDependency>, PagedArticlesBuildable {
    
    override init(dependency: PagedArticlesDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withCountry country: Country) -> PagedArticlesRouting {
        let component = PagedArticlesComponent(dependency: dependency)
        let articleBuilder = ArticleBuilder(dependency: component)
        let viewController = PagedArticlesViewController()
        let interactor = PagedArticlesInteractor(presenter: viewController,
                                                 headlinesProvider: dependency.headlinesProvider,
                                                 country: country)
        return PagedArticlesRouter(interactor: interactor,
                                   viewController: viewController,
                                   articleBuilder: articleBuilder)
    }
}
