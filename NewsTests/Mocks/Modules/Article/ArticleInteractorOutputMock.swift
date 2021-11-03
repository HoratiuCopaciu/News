//
//  ArticleInteractorOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News
import NewsDomain

final class ArticleInteractorOutputMock: ArticleInteractorOutput {
    init() { }


    private(set) var didGetArticleCallCount = 0
    var didGetArticleHandler: ((Article) -> ())?
    func didGetArticle(_ article: Article)  {
        didGetArticleCallCount += 1
        if let didGetArticleHandler = didGetArticleHandler {
            didGetArticleHandler(article)
        }
    }
}
