//
//  CountrySelectionViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 31.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CountrySelectionViewInput: AnyObject {
    func setTitle(_ title: String)
    func displayCounties(names: [String])
}

protocol CountrySelectionViewOutput {
    func viewIsReady()
    func didSelectCountry(name: String)
}

final class CountrySelectionViewController: UIViewController {
    var output: CountrySelectionViewOutput?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var countries: [String] = []

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
        tableView.register(CountryTableViewCell.nib,
                           forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
}

extension CountrySelectionViewController: CountrySelectionViewInput {
    func setTitle(_ title: String) {
        self.title = title
    }

    func displayCounties(names: [String]) {
        countries = names
        tableView.reloadData()
    }
}

extension CountrySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < countries.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier,
                                                       for: indexPath) as? CountryTableViewCell else {
                  return .init()
              }
        let name = countries[indexPath.row]
        cell.configure(with: name)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < countries.count {
            let name = countries[indexPath.row]
            output?.didSelectCountry(name: name)
        }
    }
}
