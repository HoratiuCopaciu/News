//
//  File.swift
//  
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import Foundation

public struct Article: ArticleRepresentable, Decodable, Equatable {
    public var provider: String? {
        author
    }
    
    public struct Source: Decodable, Equatable {
        public let id: String?
        public let name: String
        
        public init(id: String?,
                    name: String) {
            self.id = id
            self.name = name
        }
    }
    
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String
    public let url: URL
    public let imageURL: URL?
    public let content: String?
    
    public init(source: Source,
                author: String?,
                title: String,
                description: String,
                url: URL,
                imageURL: URL?,
                content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.imageURL = imageURL
        self.content = content
    }

    private enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, content
        case imageURL = "urlToImage"
    }
}
