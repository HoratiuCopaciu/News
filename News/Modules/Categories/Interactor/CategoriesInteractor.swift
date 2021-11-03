//
//  CategoriesInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

protocol CategoriesInteractorInput: AnyObject {
    func getCategories()
    func getCategoryAt(index: Int)
}

protocol CategoriesInteractorOutput: AnyObject {
    func didGetCategories(_ categories: [NewsCategory])
    func didGetCategory(_ category: NewsCategory)
}

final class CategoriesInteractor {
    weak var output: CategoriesInteractorOutput?
    private let categoriesProvider: CategoriesProviderProtocol
    private var categories: [NewsCategory]?
    
    init(categoriesProvider: CategoriesProviderProtocol) {
        self.categoriesProvider = categoriesProvider
    }
}

// MARK: - CategoriesInteractorInput

extension CategoriesInteractor: CategoriesInteractorInput {
    func getCategories() {
        categoriesProvider.getCategories(completion: { [weak self] result in
            let categories = try? result.get()
            self?.categories = categories
            self?.output?.didGetCategories(categories ?? [])
        })
    }
    
    func getCategoryAt(index: Int) {
        if let categories = categories,
           index < categories.count {
            output?.didGetCategory(categories[index])
        }
    }
}

