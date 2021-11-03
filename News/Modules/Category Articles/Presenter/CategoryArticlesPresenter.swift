//
//  CategoryArticlesPresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

final class CategoryArticlesPresenter {
    unowned var view: CategoryArticlesViewInput
    let interactor: CategoryArticlesInteractorInput

    init(view: CategoryArticlesViewInput,
         interactor: CategoryArticlesInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - CategoryArticlesViewOutput

extension CategoryArticlesPresenter: CategoryArticlesViewOutput {
    func viewIsReady() {
        interactor.getArticles()
    }
}

// MARK: - CategoryArticlesInteractorOutput

extension CategoryArticlesPresenter: CategoryArticlesInteractorOutput {
    func didGetArticles(result :Result<[CategoryArticle], Error>) {
        guard let articles = try? result.get() else {
            return
        }
        view.displayArticles(articles.map({
            CategoryArticleViewModel(title: $0.description, author: $0.name)
        }))
    }
}
