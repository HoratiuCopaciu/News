//
//  ArticleBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain
import Networking

protocol ArticleDependency: Dependency {
    var networkClient: NetworkClientProtocol { get }
}

final class ArticleComponent: Component<ArticleDependency> {
    var imageLoader: ImageLoaderProtocol {
        shared({
            ImageLoader(networkClient: dependency.networkClient)
        })
    }
}

protocol ArticleBuildable: Buildable {
    func build(article: Article) -> UIViewController
}

final class ArticleBuilder: Builder<ArticleDependency>, ArticleBuildable {
    func build(article: Article) -> UIViewController {
        let component = ArticleComponent(dependency: dependency)
        let viewController = ArticleViewController()
        let interactor = ArticleInteractor(article: article)
        let presenter = ArticlePresenter(view: viewController,
                                         interactor: interactor,
                                         imageLoader: component.imageLoader)

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
