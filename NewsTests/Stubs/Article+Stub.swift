//
//  Article+Stub.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

import Foundation
import NewsDomain

extension Article {
    private static let domainURL = URL(string: "https://domain.com")!
    
    static func stub(source: Source = .init(id: "id",
                                            name: "name"),
                     author: String? = "author",
                     title: String = "title",
                     description: String = "description",
                     url: URL = domainURL,
                     imageURL: URL? = nil,
                     content: String = "content") -> Article {
        .init(source: source,
              author: author,
              title: title,
              description: description,
              url: url,
              imageURL: imageURL,
              content: content)
    }
}
