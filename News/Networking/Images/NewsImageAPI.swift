//
//  NewsImageAPI.swift
//  News
//
//  Created by Horatiu Copaciu on 31.10.2021.
//

import Networking
import UIKit

enum NewsImageAPI {
    static func getImage(with url: URL) -> WebHandler<UIImage?> {
        .init(baseURL: url,
              httpMethod: .get,
              httpHeaders: [NewsAPI.HttpHeaderKey.authorization: NewsAPI.apiKey],
              responseDeserializer: .init(deserialize: { _, data in
            guard let data = data else { return nil }
            return .init(data: data)
        }))
    }
}
