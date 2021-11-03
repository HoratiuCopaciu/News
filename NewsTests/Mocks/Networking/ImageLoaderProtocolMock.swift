//
//  ImageLoaderProtocolMock.swift
//  NewsTests
//
//  Created by Horatiu Copaciu on 31.10.2021.
//

@testable import News
import UIKit

final class ImageLoaderProtocolMock: ImageLoaderProtocol {
    init() { }

    private(set) var downloadImageCallCount = 0
    var downloadImageHandler: ((URL, @escaping (UIImage?) -> Void) -> ())?
    func downloadImage(atURL url: URL, completion: @escaping (UIImage?) -> Void)  {
        downloadImageCallCount += 1
        if let downloadImageHandler = downloadImageHandler {
            downloadImageHandler(url, completion)
        }
    }

    private(set) var cancelDownloadCallCount = 0
    var cancelDownloadHandler: ((URL) -> ())?
    func cancelDownload(atURL url: URL)  {
        cancelDownloadCallCount += 1
        if let cancelDownloadHandler = cancelDownloadHandler {
            cancelDownloadHandler(url)
        }
    }
}

