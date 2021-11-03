//
//  CategoryArticlesInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain
import CoreText

protocol CategoryArticlesInteractorInput: AnyObject {
    func getArticles()
}

protocol CategoryArticlesInteractorOutput: AnyObject {
    func didGetArticles(result :Result<[CategoryArticle], Error>)
}

final class CategoryArticlesInteractor {
    weak var output: CategoryArticlesInteractorOutput?
    
    private let categoriesProvider: CategoriesProviderProtocol
    private let category: NewsCategory

    init(categoriesProvider: CategoriesProviderProtocol,
         category: NewsCategory) {
        self.categoriesProvider = categoriesProvider
        self.category = category
    }
}

// MARK: - CategoryArticlesInteractorInput

extension CategoryArticlesInteractor: CategoryArticlesInteractorInput {
    func getArticles() {
        categoriesProvider.getArticles(inCategory: category, completion: { [weak output] result in
            output?.didGetArticles(result: result)
        })
    }
}
