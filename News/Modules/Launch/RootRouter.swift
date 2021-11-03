//
//  RootRouter.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import NewsDomain

protocol RootInteractable: Interactable, CountrySelectionListener {
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable)
    func setRootViewController(_ viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let mainMenuBuilder: MainMenuBuildable
    private let countrySelectionBuilder: CountrySelectionBuildable
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         mainMenuBuilder: MainMenuBuildable,
         countrySelectionBuilder: CountrySelectionBuildable) {
        self.mainMenuBuilder = mainMenuBuilder
        self.countrySelectionBuilder = countrySelectionBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToMainMenu(for country: Country) {
        let mainMenu = mainMenuBuilder.build(for: country)
        attachChild(mainMenu)
        viewController.setRootViewController(mainMenu.viewControllable)
//        mainMenu.showHeadlines(for: country)
    }
    
    func showCountrySelection() {
        let countrySelection = countrySelectionBuilder.build(withListener: interactor)
        viewController.present(countrySelection.viewControllable)
        
    }
}
