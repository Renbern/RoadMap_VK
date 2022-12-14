// ImagePostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка изображения секции поста
final class ImagePostTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public methods

    func configure(post: Post, photoCacheService: PhotoCacheService) {
        guard let imageName = post.attachments?.first?.photo?.photos.last?.url else { return }
        postImageView.image = photoCacheService.photo(byUrl: imageName)
    }
}
