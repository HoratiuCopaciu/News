//
//  ImageLoader.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import UIKit
import Networking

protocol ImageLoaderProtocol {
    func downloadImage(atURL url: URL, completion: @escaping (UIImage?) -> Void)
    func cancelDownload(atURL url: URL)
}

final class ImageLoader {
    private let networkClient: NetworkClientProtocol
    private lazy var tasksQueue: [URL: NetworkTask] = [:]
    private lazy var cache: [URL: UIImage] = [:]
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    private func downloadImage(atURL url: URL, completion: @escaping (UIImage?) -> Void) -> NetworkTask {
        networkClient.execute(handler: NewsImageAPI.getImage(with: url),
                              completion: { result in
            let image = try? result.get()
            completion(image)
        })
    }
}

extension ImageLoader: ImageLoaderProtocol {
    func downloadImage(atURL url: URL, completion: @escaping (UIImage?) -> Void) {
        guard let image = cache[url] else {
            tasksQueue[url] = downloadImage(atURL: url, completion: { [weak self] image in
                self?.tasksQueue.removeValue(forKey: url)
                completion(image)
            })
            return
        }
        completion(image)
    }
    
    func cancelDownload(atURL url: URL) {
        let task = tasksQueue.removeValue(forKey: url)
        task?.cancel()
    }
}
