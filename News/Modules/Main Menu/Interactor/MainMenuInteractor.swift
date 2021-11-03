//
//  MainMenuInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

protocol MainMenuInteractorInput {
    func getCountry()
}

protocol MainMenuInteractorOutput: AnyObject {
    func didGetCountry(_ country: Country?)
}

final class MainMenuInteractor {
    weak var output: MainMenuInteractorOutput?
    
    private let countryProvider: CountryProviderProtocol

    init(countryProvider: CountryProviderProtocol) {
        self.countryProvider = countryProvider
    }
}

// MARK: - MainMenuInteractorInput

extension MainMenuInteractor: MainMenuInteractorInput {
    func getCountry() {
        let country = countryProvider.getCountry()
        output?.didGetCountry(country)
    }
}
