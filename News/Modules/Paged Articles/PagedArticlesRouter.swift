//
//  PagedArticlesRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 07.11.2021.
//

import RIBs
import NewsDomain

protocol PagedArticlesInteractable: Interactable {
    var router: PagedArticlesRouting? { get set }
    var listener: PagedArticlesListener? { get set }
}

protocol PagedArticlesViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PagedArticlesRouter: ViewableRouter<PagedArticlesInteractable, PagedArticlesViewControllable>, PagedArticlesRouting {
    private let articleBuilder: ArticleBuildable
    init(interactor: PagedArticlesInteractable,
         viewController: PagedArticlesViewControllable,
         articleBuilder: ArticleBuildable) {
        self.articleBuilder = articleBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func getController(forArticle article: Article) -> PagedArticleViewControllable? {
        let module = articleBuilder.build(with: article)
        attachChild(module)
        return module.viewControllable as? PagedArticleViewControllable
    }
}
