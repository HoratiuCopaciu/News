//
//  MainMenuRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 05.11.2021.
//

import RIBs
import UIKit
import NewsDomain

protocol MainMenuInteractable: Interactable, CountrySelectionListener {
    var router: MainMenuRouting? { get set }
    var listener: MainMenuListener? { get set }
}

protocol MainMenuViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
    func present(_ viewController: ViewControllable)
    func dismiss(completion: (() -> Void)?)
}

final class MainMenuRouter: ViewableRouter<MainMenuInteractable, MainMenuViewControllable> {

    private let countrySelectionBuilder: CountrySelectionBuildable
    private let headlinesBuilder: HeadlinesBuildable
    private let pagedArticlesBuilder: PagedArticlesBuildable
    
    init(interactor: MainMenuInteractable,
         viewController: MainMenuViewControllable,
         countrySelectionBuilder: CountrySelectionBuildable,
         headlinesBuilder: HeadlinesBuildable,
         pagedArticlesBuilder: PagedArticlesBuildable) {
        self.countrySelectionBuilder = countrySelectionBuilder
        self.headlinesBuilder = headlinesBuilder
        self.pagedArticlesBuilder = pagedArticlesBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private func getHeadlinesNavigationController(for country: Country) -> ViewControllable {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: "Headlines", image: nil, selectedImage: nil)
        let headlines = headlinesBuilder.build(withCountry: country)
        attachChild(headlines)
        navigationController.viewControllers = [headlines.viewControllable.uiviewController]
        return navigationController
    }
    
    private func getPagedArticlesNavigationController(for country: Country) -> ViewControllable {
        let navigationController = UINavigationController()
        let pagedArticles = pagedArticlesBuilder.build(withCountry: country)
        attachChild(pagedArticles)
        navigationController.tabBarItem = .init(title: "Articles", image: nil, selectedImage: nil)
        navigationController.viewControllers = [pagedArticles.viewControllable.uiviewController]
        return navigationController
    }
}

extension MainMenuRouter: MainMenuRouting {
    func showHeadlines(for country: Country) {
        let viewControllers = [getHeadlinesNavigationController(for: country),
                                            getPagedArticlesNavigationController(for: country)]
        viewController.setViewControllers(viewControllers)
    }
    
    func showCountrySelection() {
        let countrySelection = countrySelectionBuilder.build(withListener: interactor)
        let navigationController = UINavigationController(rootViewController: countrySelection.viewControllable.uiviewController)
        viewController.present(navigationController)
    }
}
