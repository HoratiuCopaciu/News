//
//  RootInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import NewsDomain

protocol RootRouting: ViewableRouting {
    func routeToMainMenu(for country: Country)
    func showCountrySelection()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    private let countryProvider: CountryProviderProtocol
    
    init(presenter: RootPresentable,
         countryProvider: CountryProviderProtocol) {
        self.countryProvider = countryProvider
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let country = countryProvider.getCountry() {
            router?.routeToMainMenu(for: country)
        } else {
            router?.showCountrySelection()
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension RootInteractor: CountrySelectionListener {
    func didSetCountry(_ country: Country) {
        router?.routeToMainMenu(for: country)
    }
}
