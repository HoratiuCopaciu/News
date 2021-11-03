//
//  CountryTableViewCell.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

import UIKit

final class CountryTableViewCell: UITableViewCell, ListReusable {
    @IBOutlet private var nameLabel: UILabel!

    func configure(with name: String) {
        nameLabel.text = name
    }
}
