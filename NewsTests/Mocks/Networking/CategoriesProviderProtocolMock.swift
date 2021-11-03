//
//  CategoriesProviderProtocolMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

@testable import News
import NewsDomain

final class CategoriesProviderProtocolMock: CategoriesProviderProtocol {
    init() { }

    private(set) var getCategoriesCallCount = 0
    var getCategoriesHandler: ((@escaping (Result<[NewsCategory], Error>) -> Void) -> ())?
    func getCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void)  {
        getCategoriesCallCount += 1
        if let getCategoriesHandler = getCategoriesHandler {
            getCategoriesHandler(completion)
        }
    }
    
    private(set) var getArticlesCallCount = 0
    var getArticlesHandler: ((NewsCategory, @escaping (Result<[CategoryArticle], Error>) -> Void) -> ())?
    func getArticles(inCategory category: NewsCategory, completion: @escaping (Result<[CategoryArticle], Error>) -> Void)  {
        getArticlesCallCount += 1
        if let getArticlesHandler = getArticlesHandler {
            getArticlesHandler(category, completion)
        }   
    }
}
