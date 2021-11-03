//
//  ArticleRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs

protocol ArticleInteractable: Interactable {
    var router: ArticleRouting? { get set }
    var listener: ArticleListener? { get set }
}

protocol ArticleViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ArticleRouter: ViewableRouter<ArticleInteractable, ArticleViewControllable>, ArticleRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ArticleInteractable, viewController: ArticleViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
