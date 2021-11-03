//
//  ArticleViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol ArticlePresentableListener: AnyObject {
    func loadArticle()
}

struct ArticleViewModel {
    let title: String
    let description: String
    let author: String
    let content: String?
    let image: UIImage?
}

final class ArticleViewController: UIViewController, ArticleViewControllable, PagedArticleViewControllable {

    weak var listener: ArticlePresentableListener?
    var index: Int = 0
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = .boldSystemFont(ofSize: 19)
        setupActivityIndicator()
        listener?.loadArticle()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
    }
}

extension ArticleViewController: ArticlePresentable {
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
