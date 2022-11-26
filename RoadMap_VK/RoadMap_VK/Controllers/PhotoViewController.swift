// PhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран показа фото
final class PhotoViewController: UIViewController {
    // MARK: - Private visual components

    private lazy var contentView = self.view as? PhotoView
    private lazy var networkService = VKService()

    // MARK: - Public properties

    var photos: [String] = []
    var userId = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos(userId: userId)
        setupView()
    }

    // MARK: - Private methods

    private func fetchPhotos(userId: Int) {
        print(userId)
        networkService.getPhotos(for: userId) { [weak self] result in
            // guard let self = self else { return }
            switch result {
            case let .success(photoPaths):
                guard let contentView = self?.contentView else { return }
                self?.photos = photoPaths.map(\.url)
                self?.updatePhoto(view: contentView, photoNames: photoPaths)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupView() {
        guard let contentView = contentView else { return }
        contentView.stopActivityIndicator()
        contentView.createSwipeGestureRecognizer()
        contentView.navController = navigationController
    }

    private func updatePhoto(view contentView: PhotoView, photoNames: [Url]) {
        contentView.photos = []
        for _ in photoNames {
            let userPhotoImage = photoNames
            contentView.photos = userPhotoImage
            let photoCount = contentView.photos.count
            contentView.updatePhoto(count: photoCount)
        }
    }
}
