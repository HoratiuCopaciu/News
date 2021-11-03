//
//  MainMenuPresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain

struct TabBarItemViewModel {
    let item: MainMenuTabBarItem
    let name: String
    let image: UIImage?
}

final class MainMenuPresenter {
    unowned var view: MainMenuViewInput
    let interactor: MainMenuInteractorInput
    let router: MainMenuRouterInput

    init(view: MainMenuViewInput,
         interactor: MainMenuInteractorInput,
         router: MainMenuRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MainMenuViewOutput
extension MainMenuPresenter: MainMenuInput {
    func start() {
        interactor.getCountry()
    }
}


// MARK: - MainMenuViewOutput

extension MainMenuPresenter: MainMenuViewOutput {
    func didSelectItemAtIndex(_ index: Int) {
        
    }

    func didGetCountry(_ country: Country?) {
        if let country = country {
            router.showHeadlines(for: country)
        } else {
            router.showCountrySelection()
        }
    }
}

// MARK: - MainMenuInteractorOutput

extension MainMenuPresenter: MainMenuInteractorOutput {
}

// MARK: - MainMenuRouterOutput

extension MainMenuPresenter: MainMenuRouterOutput {
    func didSelectCountry(_ country: Country) {
        router.showHeadlines(for: country)
    }
}
