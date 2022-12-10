// PhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран показа фото
final class PhotoViewController: UIViewController {
    // MARK: - Private visual components

    private lazy var contentView = self.view as? PhotoView

    // MARK: - Public properties

    var photos: [String] = []
    var userId = 0

    // MARK: - Private properties

    private let vkAPIService = VKAPIService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(userId: userId)
        setupView()
    }

    // MARK: - Private methods

    private func fetchPhotos(userId: Int) {
        vkAPIService.fetchPhotos(for: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photoPaths):
                guard let contentView = self.contentView else { return }
                self.photos = photoPaths.compactMap(\.photos.last?.url)
                RealmService.save(items: photoPaths)
                self.updatePhoto(view: contentView, photoNames: self.photos)
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

    private func updatePhoto(view contentView: PhotoView, photoNames: [String]) {
        contentView.photoNames = []
        contentView.photoNames = photoNames
        let photoCount = contentView.photoNames.count
        contentView.updatePhoto(count: photoCount)
    }

    private func loadData(userId: Int) {
        guard let contentView = contentView,
              let photosInRealm = RealmService.get(PhotoUrlPaths.self)
        else { return }
        let identifiers = photosInRealm.map(\.userId)
        if identifiers.contains(where: { tempId in userId == tempId }) {
            let userPhoto = photosInRealm.filter { $0.userId == userId }
            let photosMap = userPhoto.compactMap(\.photos.last)
            photos = photosMap.map(\.url)
            updatePhoto(view: contentView, photoNames: photos)
        } else {
            fetchPhotos(userId: userId)
        }
    }
}
