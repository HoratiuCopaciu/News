//
//  MainMenuInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 05.11.2021.
//

import RIBs
import RxSwift
import NewsDomain

protocol MainMenuRouting: ViewableRouting {
    func showHeadlines(for country: Country)
    func showCountrySelection()
}

protocol MainMenuPresentable: Presentable {
    var listener: MainMenuPresentableListener? { get set }
}

protocol MainMenuListener: AnyObject {
    func didGetCountry(_ country: Country?)
}

final class MainMenuInteractor: PresentableInteractor<MainMenuPresentable>, MainMenuInteractable, MainMenuPresentableListener {
    func getCountry() {
        country
    }
    
    weak var router: MainMenuRouting?
    weak var listener: MainMenuListener?
    private let country: Country

    init(presenter: MainMenuPresentable,
         country: Country) {
        self.country = country
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
     
        router?.showHeadlines(for: country)
    }
    
    func didSetCountry(_ country: Country) {
        router?.showHeadlines(for: country)
    }
}
