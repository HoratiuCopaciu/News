//
//  HeadlinesInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain

protocol HeadlinesInteractorInput: AnyObject {
    func getHeadlines()
    func getArticleAt(index: Int)
}

protocol HeadlinesInteractorOutput: AnyObject {
    func didGetHeadlines(result: Result<[Article], Error>)
    func didGetArticle(_ article: Article)
}

final class HeadlinesInteractor {
    weak var output: HeadlinesInteractorOutput?
    private let headlinesProvider: HeadlinesProviderProtocol
    private let country: Country
    private var articles: [Article]?
    
    init(headlinesProvider: HeadlinesProviderProtocol,
         country: Country) {
        self.headlinesProvider = headlinesProvider
        self.country = country
    }
}

// MARK: - HeadlinesInteractorInput

extension HeadlinesInteractor: HeadlinesInteractorInput {
    func getHeadlines() {
        headlinesProvider.getHeadlines(forCountry: country,
                                       completion: { [weak self] result in
            self?.articles = try? result.get()
            self?.output?.didGetHeadlines(result: result)
        })
    }
    
    func getArticleAt(index: Int) {
        if let articles = articles,
            index < articles.count {
            output?.didGetArticle(articles[index])
        }
    }
}
