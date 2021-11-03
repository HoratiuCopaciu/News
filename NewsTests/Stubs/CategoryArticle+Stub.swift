//
//  CategoryArticle+Stub.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

import Foundation
import NewsDomain

extension CategoryArticle {
    private static let domainURL = URL(string: "https://domain.com")!
    
    static func stub(id: String = "id",
                     name: String = "name",
                     description: String = "description",
                     url: URL = domainURL,
                     category: NewsCategory = .business,
                     language: String = "language",
                     country: String = "language") -> CategoryArticle {
        CategoryArticle(id: id,
                        name: name,
                        description: description,
                        url: url,
                        category: category,
                        language: language,
                        country: country)
    }
}
