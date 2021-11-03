//
//  HeadlinesProviderProtocolMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 31.10.2021.
//

import NewsDomain
@testable import News

final class HeadlinesProviderProtocolMock: HeadlinesProviderProtocol {
    init() { }

    private(set) var getHeadlinesCallCount = 0
    var getHeadlinesHandler: ((Country, @escaping (Result<[Article], Error>) -> Void) -> ())?
    func getHeadlines(forCountry country: Country, completion: @escaping (Result<[Article], Error>) -> Void)  {
        getHeadlinesCallCount += 1
        if let getHeadlinesHandler = getHeadlinesHandler {
            getHeadlinesHandler(country, completion)
        }
    }
}

