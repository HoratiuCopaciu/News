//
//  CountrySelectionInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import NewsDomain

protocol CountrySelectionRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CountrySelectionPresentable: Presentable {
    var listener: CountrySelectionPresentableListener? { get set }
    
    func setTitle(_ title: String)
    func displayCounties(names: [String])
}

protocol CountrySelectionListener: AnyObject {
    func didSetCountry(_ country: Country)
}

final class CountrySelectionInteractor: PresentableInteractor<CountrySelectionPresentable>, CountrySelectionInteractable, CountrySelectionPresentableListener {

    weak var router: CountrySelectionRouting?
    weak var listener: CountrySelectionListener?
    private let countryProvider: CountryProviderProtocol
    
    init(presenter: CountrySelectionPresentable,
         countryProvider: CountryProviderProtocol) {
        self.countryProvider = countryProvider
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.setTitle("Select Country")
        presenter.displayCounties(names: Country.allCases.map({ $0.rawValue }))
    }
    
    func didSelectCountry(named name: String) {
        if let country = Country(rawValue: name) {
            countryProvider.setCountry(country)
            listener?.didSetCountry(country)
        }
    }
}
