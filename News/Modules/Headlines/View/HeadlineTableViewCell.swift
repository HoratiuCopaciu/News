//
//  HeadlineTableViewCell.swift
//  News
//
//  Created by Horatiu Copaciu on 29.10.2021.
//

import UIKit

final class HeadlineTableViewCell: UITableViewCell, ListReusable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorLabel.textAlignment = .right
        authorLabel.textColor = .gray
    }

    func update(withArticle article: HeadlinesViewModel) {
        titleLabel.text = article.title
        authorLabel.text = article.author
    }
}
