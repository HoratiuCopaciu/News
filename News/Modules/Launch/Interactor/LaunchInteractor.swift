//
//  LaunchInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol LaunchInteractorInput: AnyObject {
}

protocol LaunchInteractorOutput: AnyObject {
}

final class LaunchInteractor {
    weak var output: LaunchInteractorOutput?

    init() {

    }
}

// MARK: - LaunchInteractorInput

extension LaunchInteractor: LaunchInteractorInput {
}
