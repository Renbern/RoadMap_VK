// AvailableGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка таблицы групп доступных для подписки
final class AvailableGroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupPhotoImageView: UIImageView!

    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public properties
    var groupPhotoImageName: String?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

// MARK: - Public properties
    func refreshPhoto(_ model: Group) {
        groupPhotoImageView.image = UIImage(named: model.groupImageName)
        groupNameLabel.text = model.name
        groupPhotoImageName = model.groupImageName
    }
}
