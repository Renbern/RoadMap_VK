// PhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран показа фото
final class PhotoViewController: UIViewController {
    // MARK: - Public properties

    var photoNames: [String] = []

    // MARK: - Private properties

    private lazy var contentView = self.view as? PhotoView

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        guard let contentView = contentView else { return }
        contentView.stopActivityIndicator()
        contentView.createSwipeGesture()
        contentView.navController = navigationController
        updatePhoto(view: contentView, photo: photoNames)
    }

    private func updatePhoto(view contentView: PhotoView, photo: [String]) {
        contentView.photos = []
        let photos = Array(photo)
        for photo in photos {
            guard let usersPhoto = UIImage(named: photo) else {
                return
            }
            contentView.photos.append(usersPhoto)
            let photoCount = contentView.photos.count
            contentView.updatePhoto(count: photoCount)
        }
    }
}
