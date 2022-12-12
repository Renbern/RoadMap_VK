// PostHeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка хэдера секции поста
final class PostHeaderTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet private var postAuthorLabel: UILabel!
    @IBOutlet private var authorImageView: UIImageView!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Private properties

    private let dateFormat = DateFormatter()

    // MARK: - Public methods

    func configure(post: Post, photoCacheService: PhotoCacheService) {
        authorImageView.image = photoCacheService.photo(byUrl: post.avatarPath ?? "")
        postAuthorLabel.text = post.authorName
        postDateLabel.text = dateFormat.convert(date: post.date)
    }
}
