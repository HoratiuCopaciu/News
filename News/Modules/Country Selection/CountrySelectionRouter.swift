//
//  CountrySelectionRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs

protocol CountrySelectionInteractable: Interactable {
    var router: CountrySelectionRouting? { get set }
    var listener: CountrySelectionListener? { get set }
}

protocol CountrySelectionViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CountrySelectionRouter: ViewableRouter<CountrySelectionInteractable, CountrySelectionViewControllable>, CountrySelectionRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CountrySelectionInteractable, viewController: CountrySelectionViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
