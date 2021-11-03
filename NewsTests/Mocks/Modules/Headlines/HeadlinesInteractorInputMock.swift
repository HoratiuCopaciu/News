//
//  HeadlinesInteractorInputMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News

final class HeadlinesInteractorInputMock: HeadlinesInteractorInput {
    init() { }

    private(set) var getHeadlinesCallCount = 0
    var getHeadlinesHandler: (() -> ())?
    func getHeadlines()  {
        getHeadlinesCallCount += 1
        if let getHeadlinesHandler = getHeadlinesHandler {
            getHeadlinesHandler()
        }
    }
    
    private(set) var getArticleAtCallCount = 0
    var getArticleAtHandler: ((Int) -> ())?
    func getArticleAt(index: Int)  {
        getArticleAtCallCount += 1
        if let getArticleAtHandler = getArticleAtHandler {
            getArticleAtHandler(index)
        }   
    }
}
