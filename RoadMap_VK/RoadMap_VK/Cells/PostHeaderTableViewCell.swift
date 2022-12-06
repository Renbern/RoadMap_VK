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

    func configure(item: NewsFeed) {
        authorImageView.load(url: item.avatarPath ?? "")
        postAuthorLabel.text = item.authorName
        postDateLabel.text = changeDateFormat(date: item.date)
    }

    // MARK: - Private methods

    private func changeDateFormat(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
