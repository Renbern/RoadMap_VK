// FriendPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции фото друга
final class FriendPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var friendPhotoImageView: UIImageView!

    // MARK: - Public methods

    func refreshPhoto(_ model: Photo) {
        guard let url = model.photo.first?.url else { return }
        friendPhotoImageView.load(url: url)
    }
}
