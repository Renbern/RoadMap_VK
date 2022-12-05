// PostHeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка хэдера секции поста
final class PostHeaderTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet private var postAuthorLabel: UILabel!
    @IBOutlet private var authorImageView: UIImageView!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public methods

    func configure(item: PostItem) {
        authorImageView.image = UIImage(named: item.photo ?? "")
        postAuthorLabel.text = item.author
        postDateLabel.text = item.postDate
    }
}
