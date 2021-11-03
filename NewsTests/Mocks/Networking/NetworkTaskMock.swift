//
//  NetworkTaskMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 31.10.2021.
//

import Networking

public class NetworkTaskMock: NetworkTask {
    public init() { }

    public private(set) var resumeCallCount = 0
    public var resumeHandler: (() -> ())?
    public func resume()  {
        resumeCallCount += 1
        if let resumeHandler = resumeHandler {
            resumeHandler()
        }
    }

    public private(set) var cancelCallCount = 0
    public var cancelHandler: (() -> ())?
    public func cancel()  {
        cancelCallCount += 1
        if let cancelHandler = cancelHandler {
            cancelHandler()
        }
    }
}
