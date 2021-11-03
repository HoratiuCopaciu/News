//
//  NetworkClientProtocolMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 31.10.2021.
//

import Networking

public class NetworkClientProtocolMock: NetworkClientProtocol {
    public init() { }

    public private(set) var executeCallCount = 0
    public var executeHandler: ((Any, Any) -> (NetworkTask))?
    public func execute<Response>(handler: WebHandler<Response>, completion: @escaping (Result<Response, Error>) -> Void) -> NetworkTask {
        executeCallCount += 1
        if let executeHandler = executeHandler {
            return executeHandler(handler, completion)
        }
        return NetworkTaskMock()
    }
}

