//
//  CategoryArticle.swift
//  
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

import Foundation

public struct CategoryArticle: ArticleRepresentable, Decodable, Equatable {
    public var title: String {
        description
    }
    
    public var provider: String? {
        name
    }
    
    public let id: String
    public let name: String
    public let description: String
    public let url: URL
    public let category: NewsCategory
    public let language: String
    public let country: String
    
    public init(id: String,
                name: String,
                description: String,
                url: URL,
                category: NewsCategory,
                language: String,
                country: String) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}
