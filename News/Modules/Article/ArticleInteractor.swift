//
//  ArticleInteractor.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import NewsDomain
import UIKit

protocol ArticleRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ArticlePresentable: Presentable {
    var listener: ArticlePresentableListener? { get set }
    
    func startLoading()
    func stopLoading()
    func displayArticle(_ article: ArticleViewModel)
}

protocol ArticleListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ArticleInteractor: PresentableInteractor<ArticlePresentable>, ArticleInteractable, ArticlePresentableListener {

    weak var router: ArticleRouting?
    weak var listener: ArticleListener?

    private let imageLoader: ImageLoaderProtocol
    private let article: Article
    
    init(presenter: ArticlePresentable,
         imageLoader: ImageLoaderProtocol,
         article: Article) {
        self.imageLoader = imageLoader
        self.article = article
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func loadArticle() {
        presenter.startLoading()
        getViewModel(for: article,
                        completion: { [weak presenter] model in
            presenter?.stopLoading()
            presenter?.displayArticle(model)
        })
    }
        
    override func willResignActive() {
        super.willResignActive()
    }
}

private extension ArticleInteractor {
    func getViewModel(for article: Article,
                      completion: @escaping (ArticleViewModel) -> Void) {
        guard let imageURL = article.imageURL else {
            completion(.init(article: article, image: nil))
            return
        }
        imageLoader.downloadImage(atURL: imageURL,
                                  completion: { image in
            completion(.init(article: article, image: image))
        })
    }
}

private extension ArticleViewModel {
    init(article: Article, image: UIImage?) {
        self.title = article.title
        self.description = article.description
        self.content = article.content
        self.image = image
        
        if let author = article.author {
            self.author = "Author: \(author)"
        } else {
            self.author = "Unknown author"
        }
    }
}
