//
//  CategoriesPresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

final class CategoriesPresenter {
    unowned var view: CategoriesViewInput
    let interactor: CategoriesInteractorInput
    let router: CategoriesRouterInput
    
    init(view: CategoriesViewInput,
         interactor: CategoriesInteractorInput,
         router: CategoriesRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - CategoriesViewOutput

extension CategoriesPresenter: CategoriesViewOutput {
    func viewIsReady() {
        view.setTitle("News Categories")
        interactor.getCategories()
    }
    
    func didSelectCategoryAt(index: Int) {
        interactor.getCategoryAt(index: index)
    }
}

// MARK: - CategoriesInteractorOutput

extension CategoriesPresenter: CategoriesInteractorOutput {
    func didGetCategories(_ categories: [NewsCategory]) {
        view.displayCategories(categories.map({ CategoryViewModel(name: $0.rawValue.capitalized) }))
    }
    
    func didGetCategory(_ category: NewsCategory) {
        router.showCategory(category)
    }
}

// MARK: - CategoriesRouterOutput

extension CategoriesPresenter: CategoriesRouterOutput {
}
