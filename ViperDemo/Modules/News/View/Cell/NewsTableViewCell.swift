//
//  NewsTableViewCell.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!

    private var cellModel: NewsCellModel?

    func bindData(_ cellModel: NewsCellModel) {
        self.cellModel = cellModel
        titleLabel.text = cellModel.title
        authorLabel.text = cellModel.author
        descriptionLabel.text = cellModel.desc
        contentLabel.text = cellModel.content
        publishedAtLabel.text = cellModel.publishedAt
        if let imageURL = cellModel.imageURL {
            contentImageView.imageFromServerURL(imageURL, placeHolder: nil)
        }
    }

}
