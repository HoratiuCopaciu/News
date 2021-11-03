//
//  CategoriesProvider.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

import NewsDomain
import Networking

protocol CategoriesProviderProtocol {
    func getCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void)
    func getArticles(inCategory category: NewsCategory, completion: @escaping (Result<[CategoryArticle], Error>) -> Void)
}

final class CategoriesProvider: CategoriesProviderProtocol {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }

    func getCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void) {
        completion(.success(NewsCategory.allCases))
    }
    
    func getArticles(inCategory category: NewsCategory, completion: @escaping (Result<[CategoryArticle], Error>) -> Void) {
        client.execute(handler: CategoriesAPI.getArticles(inCategory: category),
                       completion: { result in
            completion(result.map({ $0.sources }))
        })
    }
}
