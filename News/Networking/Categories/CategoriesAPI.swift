//
//  CategoriesAPI.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

import Foundation
import NewsDomain
import Networking

enum CategoriesAPI {
    static func getArticles(inCategory category: NewsCategory) -> WebHandler<CategoriesArticlesResponse> {
        .init(baseURL: NewsAPI.baseURL,
              httpMethod: .get,
              urlPaths: [NewsAPI.URLPaths.v2,
                         NewsAPI.URLPaths.topHeadlines,
                         NewsAPI.URLPaths.sources],
              httpHeaders: ["Authorization": NewsAPI.apiKey],
              queryParameters: ["category": category.rawValue],
              expectedStatusCode: 200,
              parameterSerializer: .json(serialize: { nil }),
              responseDeserializer: .json(decoder: JSONDecoder()))
    }
}

extension CategoriesAPI {
    struct CategoriesArticlesResponse: Decodable {
        let status: String
        let sources: [CategoryArticle]
    }
}
