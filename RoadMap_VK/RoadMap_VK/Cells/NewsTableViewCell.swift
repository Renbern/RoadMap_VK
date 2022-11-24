// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка поста новостей
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var postAuthorLabel: UILabel!
    @IBOutlet private var postTextLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var commentButton: UIButton!
    @IBOutlet private var viewCountLabel: UILabel!
}
