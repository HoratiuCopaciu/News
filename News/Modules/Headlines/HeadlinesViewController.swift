//
//  HeadlinesViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol HeadlinesPresentableListener: AnyObject {
    func didSelectArticleAt(index: Int)
    func refresh()
}

struct HeadlinesViewModel: Equatable {
    let title: String
    let author: String?
}

final class HeadlinesViewController: UIViewController {

    weak var listener: HeadlinesPresentableListener?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var refreshControl = UIRefreshControl()
    private var articles: [HeadlinesViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupRefreshControl()
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
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self,
                                 action: #selector(refresh),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        listener?.refresh()
    }
}

extension HeadlinesViewController: HeadlinesViewControllable {
    func push(_ viewController: ViewControllable) {
        navigationController?.pushViewController(viewController.uiviewController,
                                                 animated: true)
    }
}

extension HeadlinesViewController: HeadlinesPresentable {
    func showHeadlines(articles: [HeadlinesViewModel]) {
        self.articles = articles
        tableView.reloadData()
        refreshControl.endRefreshing()
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
        listener?.didSelectArticleAt(index: indexPath.row)
    }
}

