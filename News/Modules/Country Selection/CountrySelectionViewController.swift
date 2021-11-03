//
//  CountrySelectionViewController.swift
//  News
//
//  Created by Horatiu Copaciu on 06.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol CountrySelectionPresentableListener: AnyObject {
    func didSelectCountry(named name: String)
}

final class CountrySelectionViewController: UIViewController, CountrySelectionViewControllable {

    weak var listener: CountrySelectionPresentableListener?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var countries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
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

extension CountrySelectionViewController: CountrySelectionPresentable {
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
            listener?.didSelectCountry(named: name)
        }
    }
}
