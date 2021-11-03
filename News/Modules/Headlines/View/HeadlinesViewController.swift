//
//  HeadlinesViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Networking

struct HeadlinesViewModel: Equatable {
    let title: String
    let author: String?
}

protocol HeadlinesViewInput: AnyObject {
    func setTitle(_ title: String)
    func displayArticles(_ articles: [HeadlinesViewModel])
}

protocol HeadlinesViewOutput: AnyObject {
    func viewIsReady()
    func didSelectArticleAt(index: Int)
}

final class HeadlinesViewController: UIViewController {
    var output: HeadlinesViewOutput?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var articles: [HeadlinesViewModel] = []
    
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

extension HeadlinesViewController: HeadlinesViewInput {
    func setTitle(_ title: String) {
        self.title = title
    }

    func displayArticles(_ articles: [HeadlinesViewModel]) {
        self.articles = articles
        tableView.reloadData()
    }
    
    func displayArticle(_ article: HeadlinesViewModel, at index: Int) {
        guard index < articles.count else {
            return
        }
        articles[index] = article
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)],
                             with: .automatic)
    }
}

extension HeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.didSelectArticleAt(index: indexPath.row)
    }
}
