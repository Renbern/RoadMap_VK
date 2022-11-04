// FriendPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции фото друга
final class FriendPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Public visual elements
    @IBOutlet var friendPhotoImageView: UIImageView!

    // MARK: - Public methods

    func refreshPhoto(_ model: User) {
        friendPhotoImageView.image = UIImage(named: model.friendPhotoImageName)
    }
}
