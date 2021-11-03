//
//  WebHandlerParameterSerializer.swift
//  
//
//  Created by Horatiu Copaciu on 30.10.2021.
//

import Foundation

public struct WebHandlerParameterSerializer {
    public enum ContentType: String {
        case json = "application/json"
    }
    
    public let contentType: ContentType
    public let serialize: () throws -> Data?
    
    public init(contentType: ContentType,
                serialize: @escaping () throws -> Data?) {
        self.contentType = contentType
        self.serialize = serialize
    }
    
    public static func json(serialize: @escaping () throws -> Data?) -> Self {
        .init(contentType: .json, serialize: serialize)
    }
}
