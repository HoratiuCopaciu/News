//
//  ArticleBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import NewsDomain
import Networking

protocol ArticleDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
}

final class ArticleComponent: Component<ArticleDependency> {
    fileprivate var imageLoader: ImageLoaderProtocol {
        shared({
            ImageLoader(networkClient: dependency.networkClient)
        })
    }
}

// MARK: - Builder

protocol ArticleBuildable: Buildable {
    func build(with article: Article) -> ArticleRouting
}

final class ArticleBuilder: Builder<ArticleDependency>, ArticleBuildable {

    override init(dependency: ArticleDependency) {
        super.init(dependency: dependency)
    }

    func build(with article: Article) -> ArticleRouting {
        let component = ArticleComponent(dependency: dependency)
        let viewController = ArticleViewController()
        let interactor = ArticleInteractor(presenter: viewController,
                                           imageLoader: component.imageLoader,
                                           article: article)
        return ArticleRouter(interactor: interactor, viewController: viewController)
    }
}
