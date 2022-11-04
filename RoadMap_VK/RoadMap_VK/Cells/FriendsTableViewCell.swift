// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка таблицы друзей
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var friendView: FriendView!
    @IBOutlet private var friendNameLabel: UILabel!

    // MARK: - Public properties

    var friendPhotoImageName: String?

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public methods
    func refreshPhoto(_ model: User) {
        friendPhotoImageView.image = UIImage(named: model.friendPhotoImageName)
        friendNameLabel.text = model.name
        friendPhotoImageName = model.friendPhotoImageName
    }
    
    // MARK: - Private methods

    private func setupUI() {
        friendView.configureShadow()
    }
}
