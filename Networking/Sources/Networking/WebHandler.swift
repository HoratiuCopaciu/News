//
//  WebHandler.swift
//  
//
//  Created by Horatiu Copaciu on 30.10.2021.
//

import Foundation

public final class WebHandler<Response> {
    public enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    private let baseURL: URL
    private let urlPaths: [String]
    private let httpMethod: HttpMethod
    private let httpHeaders: [String: String]?
    private let queryParameters: [String: String]?
    private let statusCodeValidator: (Int) -> Bool
    private let parameterSerializer: WebHandlerParameterSerializer?
    private let responseDeserializer: WebHandlerResponseDeserializer<Response>
    
    
    public init(baseURL: URL,
                httpMethod: HttpMethod,
                urlPaths: [String] = [],
                httpHeaders: [String: String]? = nil,
                queryParameters: [String: String]? = nil,
                expectedStatusCode: Int = 200,
                parameterSerializer: WebHandlerParameterSerializer? = nil,
                responseDeserializer: WebHandlerResponseDeserializer<Response>) {
        self.baseURL = baseURL
        self.urlPaths = urlPaths
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.queryParameters = queryParameters
        self.statusCodeValidator = { $0 == expectedStatusCode }
        self.parameterSerializer = parameterSerializer
        self.responseDeserializer = responseDeserializer
    }
    
    public func deserialize(_ statusCode: Int, _ data: Data?) throws -> Response {
        try responseDeserializer.deserialize(statusCode, data)
    }
    
    public func validate(statusCode: Int) -> Bool {
        statusCodeValidator(statusCode)
    }
}

extension WebHandler where Response: Decodable {
    public static func getJSON(baseURL: URL,
                               urlPaths: [String] = [],
                               queryParameters: [String: String]? = nil) -> WebHandler<Response> {
        WebHandler(baseURL: baseURL,
                   httpMethod: .get,
                   urlPaths: urlPaths,
                   queryParameters: queryParameters,
                   parameterSerializer: .json(serialize: { nil }),
                   responseDeserializer: .json(decoder: JSONDecoder()))
    }
}

extension WebHandler: URLRequestConvertible {
    private enum HttpHeaderFields: String {
        case accept = "Accept"
        case contentType = "Content-Type"
    }
    
    public func asURLRequest() -> URLRequest {
        let url: URL = {
            let url = baseURL.appendingPathComponent(NSString.path(withComponents: urlPaths))

            guard let query = queryParameters, !query.isEmpty else {
                return url
            }
            return addqueryParameters(query, to: url)
        }()
                                       
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        httpHeaders?.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameterSerializer = parameterSerializer {
            request.httpBody = try? parameterSerializer.serialize()
            request.setValue(parameterSerializer.contentType.rawValue,
                             forHTTPHeaderField: HttpHeaderFields.contentType.rawValue)
        }
        
        return request
    }
    
    private func addqueryParameters(_ queryParameters: [String: String],
                                    to url: URL) -> URL {
        guard !queryParameters.isEmpty,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                  assertionFailure("Could not build URL")
                  return url
              }
        var queryItems = components.queryItems ?? []
        queryItems.append(contentsOf: queryParameters.map { URLQueryItem(name: $0.0, value: $0.1) })
        components.queryItems = queryItems
        
        return components.url ?? url
    }
}
