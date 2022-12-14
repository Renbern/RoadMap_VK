// TextPostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста секции поста
final class TextPostTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet var postTextLabel: UILabel!

    // MARK: - Public methods

    func configure(post: Post, photoCacheService: PhotoCacheService) {
        postTextLabel.text = post.text
        postTextLabel.numberOfLines = 5
    }
}
