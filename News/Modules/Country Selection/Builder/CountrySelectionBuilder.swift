//
//  CountrySelectionBuilder.swift
//  News
//
//  Created by Horatiu Copaciu on 31.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NewsDomain

protocol CountrySelectionDependency: Dependency {
    var countryProvider: CountryProviderProtocol { get }
}

typealias CountrySelectionCompletionHandler = (Country) -> Void

protocol CountrySelectionBuildable: Buildable {
    func build(handler: @escaping CountrySelectionCompletionHandler) -> UIViewController
}

final class CountrySelectionBuilder: Builder<CountrySelectionDependency>, CountrySelectionBuildable {
    func build(handler: @escaping CountrySelectionCompletionHandler) -> UIViewController {
        let viewController = CountrySelectionViewController()
        let interactor = CountrySelectionInteractor(countryProvider: dependency.countryProvider)
        let presenter = CountrySelectionPresenter(view: viewController,
                                                  interactor: interactor,
                                                  completionHandler: handler)
        
        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
