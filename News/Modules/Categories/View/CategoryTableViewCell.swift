//
//  CategoryTableViewCell.swift
//  News
//
//  Created by Horatiu Copaciu on 01.11.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, ListReusable {
    @IBOutlet private var nameLabel: UILabel!
    
    func setCategory(_ name: String) {
        nameLabel.text = name
    }
}
