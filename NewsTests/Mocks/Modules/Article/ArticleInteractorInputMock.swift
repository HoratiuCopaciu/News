//
//  ArticleInteractorInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

@testable import News

final class ArticleInteractorInputMock: ArticleInteractorInput {
    init() { }

    private(set) var getArticleCallCount = 0
    var getArticleHandler: (() -> ())?
    func getArticle()  {
        getArticleCallCount += 1
        if let getArticleHandler = getArticleHandler {
            getArticleHandler()
        }        
    }
}
