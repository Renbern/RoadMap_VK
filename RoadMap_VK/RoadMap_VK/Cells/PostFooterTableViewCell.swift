// PostFooterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка футера секции поста
final class PostFooterTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet var postLikeControl: PostLikeControl!

    // MARK: - Public methods

    func configure(post: Post) {
        postLikeControl.configure(post: post)
    }
}
