// PhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран показа фото
final class PhotoViewController: UIViewController {
    // MARK: - Private visual components

    private lazy var contentView = self.view as? PhotoView
    private lazy var service = VKService()

    // MARK: - Public properties

    var photoNames: [Photo] = []
    var userId = Int()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        guard let contentView = contentView else { return }
        contentView.stopActivityIndicator()
        contentView.createSwipeGestureRecognizer()
        contentView.navController = navigationController
        service.sendPhotoRequest(urlString: String(userId)) { [weak self] photos in
            self?.photoNames = photos.response.photos
            guard let userPhotoNames = self?.photoNames else { return }
            self?.updatePhoto(view: contentView, photoNames: userPhotoNames)
        }
    }

    private func updatePhoto(view contentView: PhotoView, photoNames: [Photo]) {
        contentView.photoImages = []
        for _ in photoNames {
            let userPhotoImage = photoNames
            contentView.photoImages = userPhotoImage
            let photoCount = contentView.photoImages.count
            contentView.updatePhoto(count: photoCount)
        }
    }
}
