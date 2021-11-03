//
//  CategoriesViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct CategoryViewModel {
    let name: String
}

protocol CategoriesViewInput: AnyObject {
    func setTitle(_ title: String)
    func displayCategories(_ categories: [CategoryViewModel])
}

protocol CategoriesViewOutput {
    func viewIsReady()
    func didSelectCategoryAt(index: Int)
}

final class CategoriesViewController: UIViewController {
    var output: CategoriesViewOutput?
    
    private var categories: [CategoryViewModel] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        tableView.register(CategoryTableViewCell.nib,
                           forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.estimatedRowHeight = 1
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension CategoriesViewController: CategoriesViewInput {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func displayCategories(_ categories: [CategoryViewModel]) {
        self.categories = categories
        tableView.reloadData()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard index < categories.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                       for: indexPath) as? CategoryTableViewCell else {
                  return .init()
              }
        
        let category = categories[index]
        cell.setCategory(category.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.didSelectCategoryAt(index: indexPath.row)
    }
}
