//
//  HeadlinesAPI.swift
//  News
//
//  Created by Horatiu Copaciu on 30.10.2021.
//

import Foundation
import Networking
import NewsDomain

enum HeadlinesAPI {
    static func getHeadlines(forCountry country: Country) -> WebHandler<HeadlinesResponse> {
        .init(baseURL: NewsAPI.baseURL,
              httpMethod: .get,
              urlPaths: [NewsAPI.URLPaths.v2,
                         NewsAPI.URLPaths.topHeadlines],
              httpHeaders: [NewsAPI.HttpHeaderKey.authorization: NewsAPI.apiKey],
              queryParameters: ["country": country.isoCode],
              expectedStatusCode: 200,
              parameterSerializer: .json(serialize: { nil }),
              responseDeserializer: .json(decoder: JSONDecoder()))
    }
}

extension HeadlinesAPI {
    struct HeadlinesResponse: Decodable {
        let totalResults: Int
        let articles: [Article]
    }
}
