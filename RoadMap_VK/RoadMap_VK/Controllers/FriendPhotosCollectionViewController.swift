// FriendPhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица фото друга
final class FriendPhotosCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let reuseIdentifier = "friendPhotoCell"
    }

    // MARK: - Public properties

    var friendImageName: String?
}

// MARK: - UICollectionViewDataSource

extension FriendPhotosCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.reuseIdentifier,
            for: indexPath
        ) as? FriendPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.refreshPhoto(friendImageName)

        return cell
    }
}
