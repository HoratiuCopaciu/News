//
//  URLRequestConvertibleMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 31.10.2021.
//

import Foundation
import Networking

public class URLRequestConvertibleMock: URLRequestConvertible {
    public init() { }

    public private(set) var asURLRequestCallCount = 0
    public var asURLRequestHandler: (() -> (URLRequest))?
    public func asURLRequest() -> URLRequest {
        asURLRequestCallCount += 1
        if let asURLRequestHandler = asURLRequestHandler {
            return asURLRequestHandler()
        }
        fatalError("asURLRequestHandler returns can't have a default value thus its handler must be set")
    }
}
