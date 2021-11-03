//
//  HeadlinesProvider.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import NewsDomain
import Networking

protocol HeadlinesProviderProtocol {
    func getHeadlines(forCountry country: Country, completion: @escaping (Result<[Article], Error>) -> Void)
}

final class HeadlinesProvider: HeadlinesProviderProtocol {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func getHeadlines(forCountry country: Country, completion: @escaping (Result<[Article], Error>) -> Void) {
        client.execute(handler: HeadlinesAPI.getHeadlines(forCountry: country),
                       completion: { result in
            completion(result.map({ $0.articles }))
        })
    }
}
