//
//  CountrySelectionPresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 31.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain
import Foundation

final class CountrySelectionPresenter {
    unowned var view: CountrySelectionViewInput
    let interactor: CountrySelectionInteractorInput

    private let completionHandler: CountrySelectionCompletionHandler

    init(view: CountrySelectionViewInput,
         interactor: CountrySelectionInteractorInput,
         completionHandler: @escaping CountrySelectionCompletionHandler) {
        self.view = view
        self.interactor = interactor
        self.completionHandler = completionHandler
    }
}

// MARK: - CountrySelectionViewOutput

extension CountrySelectionPresenter: CountrySelectionViewOutput {
    func viewIsReady() {
        view.setTitle("Select Country")
        interactor.getAvailableCountries()
    }
    
    func didSelectCountry(name: String) {
        if let country = Country(rawValue: name) {
            interactor.setCountry(country)
        }
    }
}

// MARK: - CountrySelectionInteractorOutput

extension CountrySelectionPresenter: CountrySelectionInteractorOutput {
    func didGetAvailableCountries(_ countries: [Country]) {
        view.displayCounties(names: countries.map({ $0.rawValue }))
    }

    func didSetCountry(_ country: Country) {
        completionHandler(country)
    }
}
