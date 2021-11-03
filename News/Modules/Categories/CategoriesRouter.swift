//
//  CategoriesRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs

protocol CategoriesInteractable: Interactable {
    var router: CategoriesRouting? { get set }
    var listener: CategoriesListener? { get set }
}

protocol CategoriesViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CategoriesRouter: ViewableRouter<CategoriesInteractable, CategoriesViewControllable>, CategoriesRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CategoriesInteractable, viewController: CategoriesViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
