//
//  CategoryArticlesViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 02.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

typealias CategoryArticleViewModel = HeadlinesViewModel

protocol CategoryArticlesViewInput: AnyObject {
    func setTitle(_ title: String)
    func displayArticles(_ articles: [CategoryArticleViewModel])
}

protocol CategoryArticlesViewOutput {
    func viewIsReady()
}

final class CategoryArticlesViewController: UIViewController {
    var output: CategoryArticlesViewOutput?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var articles: [CategoryArticleViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        output?.viewIsReady()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.constraint(into: view)
        tableView.register(HeadlineTableViewCell.nib,
                           forCellReuseIdentifier: HeadlineTableViewCell.identifier)
        tableView.estimatedRowHeight = 1
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension CategoryArticlesViewController: CategoryArticlesViewInput {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func displayArticles(_ articles: [CategoryArticleViewModel]) {
        self.articles = articles
        tableView.reloadData()
    }
}

extension CategoryArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard index < articles.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier,
                                                       for: indexPath) as? HeadlineTableViewCell else {
                  return .init()
              }
        
        let article = articles[index]
        cell.update(withArticle: article)
        
        return cell
    }
}
