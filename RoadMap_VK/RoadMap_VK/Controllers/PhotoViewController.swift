// PhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран показа фото
final class PhotoViewController: UIViewController {
    // MARK: - Private visual components

    private lazy var contentView = self.view as? PhotoView

    // MARK: - Public properties

    var photoNames: [String] = []

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
        updatePhoto(view: contentView, photoNames: photoNames)
    }

    private func updatePhoto(view contentView: PhotoView, photoNames: [String]) {
        contentView.photoImages = []
        for photoName in photoNames {
            guard let userPhotoImage = UIImage(named: photoName) else {
                return
            }
            contentView.photoImages.append(userPhotoImage)
            let photoCount = contentView.photoImages.count
            contentView.updatePhoto(count: photoCount)
        }
    }
}
