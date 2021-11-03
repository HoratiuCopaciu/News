//
//  ArticleInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

protocol ArticleInteractorInput: AnyObject {
    func getArticle()
}

protocol ArticleInteractorOutput: AnyObject {
    func didGetArticle(_ article: Article)
}

final class ArticleInteractor {
    weak var output: ArticleInteractorOutput?
    private let article: Article

    init(article: Article) {
        self.article = article
    }
}

// MARK: - ArticleInteractorInput

extension ArticleInteractor: ArticleInteractorInput {
    func getArticle() {
        output?.didGetArticle(article)
    }
}
