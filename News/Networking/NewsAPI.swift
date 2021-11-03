//
//  NewsAPI.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//

import Foundation

enum NewsAPI {
    static let baseURL = URL(string: "https://newsapi.org")!
    static let apiKey: String = {
        assertionFailure("Missing API key")
        return ""
    }()
}

extension NewsAPI {
    enum URLPaths {
        static let v2 = "v2"
        static let topHeadlines = "top-headlines"
        static let sources = "sources"
    }
    
    enum HttpHeaderKey {
        static let authorization = "Authorization"
    }
}
