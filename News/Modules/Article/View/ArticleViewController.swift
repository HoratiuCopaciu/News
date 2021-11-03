//
//  ArticleViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ArticleViewModel {
    let title: String
    let description: String
    let author: String
    let content: String?
    let image: UIImage?
}

protocol ArticleViewInput: AnyObject {
    func startLoading()
    func stopLoading()
    func displayArticle(_ article: ArticleViewModel)
}

protocol ArticleViewOutput {
    func viewIsReady()
}

final class ArticleViewController: UIViewController {
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!

    var output: ArticleViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = .boldSystemFont(ofSize: 19)
        setupActivityIndicator()
        output?.viewIsReady()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
    }
}

extension ArticleViewController: ArticleViewInput {
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func displayArticle(_ article: ArticleViewModel) {
        imageView.image = article.image
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.author
        contentLabel.text = article.content
    }
}
