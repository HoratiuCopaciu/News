//
//  NetworkClient.swift
//  
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import Foundation

public protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest
}

public protocol NetworkClientProtocol {
    @discardableResult
    func execute<Response>(handler: WebHandler<Response>,
                           completion: @escaping (Result<Response, Error>) -> Void) -> NetworkTask
}

public final class NetworkClient {
    private let session: URLSession
    private let dispatchQueue: DispatchQueue
    
    public init(session: URLSession,
                dispatchQueue: DispatchQueue = .main) {
        self.session = session
        self.dispatchQueue = dispatchQueue
    }
    
    @discardableResult
    private func execute(request: URLRequestConvertible,
                         completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTask {
        let task = session.dataTask(with: request.asURLRequest(),
                                    completionHandler: completion)
        task.resume()
        return task
    }
}

extension NetworkClient: NetworkClientProtocol {
    @discardableResult
    public func execute<Response>(handler: WebHandler<Response>,
                                  completion: @escaping (Result<Response, Error>) -> Void) -> NetworkTask {
        execute(request: handler,
                completion: { [weak self] data, response, error in
            let result: Result<Response, Error>
            
            if let httpResponse = response as? HTTPURLResponse,
               handler.validate(statusCode: httpResponse.statusCode) {
                do {
                    let value = try handler.deserialize(httpResponse.statusCode, data)
                    result = .success(value)
                } catch {
                    result = .failure(error)
                }
            } else {
                let error = error ?? UnknownError()
                result = .failure(error)
            }
            
            self?.dispatchQueue.async {
                completion(result)
            }
        })
    }
}

struct UnknownError: Error {}
