//
//  ArticlePresenter.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import NewsDomain
import UIKit

final class ArticlePresenter {
    unowned var view: ArticleViewInput
    let interactor: ArticleInteractorInput

    private let imageLoader: ImageLoaderProtocol

    init(view: ArticleViewInput,
         interactor: ArticleInteractorInput,
         imageLoader: ImageLoaderProtocol) {
        self.view = view
        self.interactor = interactor
        self.imageLoader = imageLoader
    }
}

// MARK: - ArticleViewOutput

extension ArticlePresenter: ArticleViewOutput {
    func viewIsReady() {
        view.startLoading()
        interactor.getArticle()
    }
}

// MARK: - ArticleInteractorOutput

extension ArticlePresenter: ArticleInteractorOutput {
    func didGetArticle(_ article: Article) {
        if let imageURL = article.imageURL {
            imageLoader.downloadImage(atURL: imageURL,
                                      completion: { [weak view] image in
                view?.stopLoading()
                view?.displayArticle(.init(article: article, image: image))
            })
        } else {
            view.stopLoading()
            view.displayArticle(.init(article: article, image: nil))
        }
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
