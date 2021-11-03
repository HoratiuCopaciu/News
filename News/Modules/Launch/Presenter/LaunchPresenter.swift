//
//  LaunchPresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

final class LaunchPresenter {
    let interactor: LaunchInteractorInput
    let router: LaunchRouterInput

    init(interactor: LaunchInteractorInput,
         router: LaunchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - LaunchInput

extension LaunchPresenter: LaunchInput {
}

// MARK: - LaunchInteractorOutput

extension LaunchPresenter: LaunchInteractorOutput {
}

// MARK: - LaunchRouterOutput

extension LaunchPresenter: LaunchRouterOutput {
}
