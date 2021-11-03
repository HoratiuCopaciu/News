//
//  HeadlinesRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import NewsDomain

protocol HeadlinesInteractable: Interactable {
    var router: HeadlinesRouting? { get set }
    var listener: HeadlinesListener? { get set }
}

protocol HeadlinesViewControllable: ViewControllable {
    func push(_ viewController: ViewControllable)
}

final class HeadlinesRouter: ViewableRouter<HeadlinesInteractable, HeadlinesViewControllable> {

    private let articleBuilder: ArticleBuildable

    init(interactor: HeadlinesInteractable,
         viewController: HeadlinesViewControllable,
         articleBuilder: ArticleBuildable) {
        self.articleBuilder = articleBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension HeadlinesRouter: HeadlinesRouting {
    func routeToHeadline(_ article: Article) {
        let input = articleBuilder.build(with: article)
        attachChild(input)
        self.viewController.push(input.viewControllable)
    }
}
