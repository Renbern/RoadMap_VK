// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка поста новостей
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var postAuthor: UILabel!
    @IBOutlet private var postText: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var commentButton: UIButton!
    @IBOutlet private var viewCount: UILabel!

    // MARK: - Public methods

    func refreshPost(_ model: Post) {
        postImageView.image = UIImage(named: model.postImageName)
        postText.text = model.postText
        postAuthor.text = model.postAuthor
    }
}
