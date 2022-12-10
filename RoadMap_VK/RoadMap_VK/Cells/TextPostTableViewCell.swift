// TextPostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста секции поста
final class TextPostTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public methods

    func configure(post: Post, image: UIImage?) {
        postTextView.text = post.text
    }
}
