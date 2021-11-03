//
//  HeadlinesInteractorOutputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class HeadlinesInteractorOutputMock: HeadlinesInteractorOutput {
    init() { }

    private(set) var didGetHeadlinesCallCount = 0
    var didGetHeadlinesHandler: ((Result<[Article], Error>) -> ())?
    func didGetHeadlines(result: Result<[Article], Error>)  {
        didGetHeadlinesCallCount += 1
        if let didGetHeadlinesHandler = didGetHeadlinesHandler {
            didGetHeadlinesHandler(result)
        }        
    }
    
    private(set) var didGetArticleCallCount = 0
    var didGetArticleHandler: ((Article) -> ())?
    func didGetArticle(_ article: Article)  {
        didGetArticleCallCount += 1
        if let didGetArticleHandler = didGetArticleHandler {
            didGetArticleHandler(article)
        }
    }
}

