// PhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран показа фото
final class PhotoViewController: UIViewController {
    // MARK: - Private visual components

    private lazy var contentView = self.view as? PhotoView
    private lazy var networkService = VKService()
    private lazy var realmService = RealmService()

    // MARK: - Public properties

    var photos: [String] = []
    var userId = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(userId: userId)
        setupView()
    }

    // MARK: - Private methods

    private func fetchPhotos(userId: Int) {
        networkService.getPhotos(for: userId) { [weak self] result in
            switch result {
            case let .success(photoPaths):
                guard let contentView = self?.contentView else { return }
                self?.photos = photoPaths.compactMap(\.photos.last?.url)
                self?.realmService.saveInRealm(photoPaths)
                self?.updatePhoto(view: contentView, photoNames: self?.photos ?? [])
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
        contentView.photos = []
        contentView.photos = photoNames
        let photoCount = contentView.photos.count
        contentView.updatePhoto(count: photoCount)
    }

    private func loadData(userId: Int) {
        do {
            let realm = try Realm()
            guard let contentView = contentView else { return }
            var photosInRealm = Array(realm.objects(PhotoUrlPaths.self))
            let identifiers = photosInRealm.map(\.userId)
            if identifiers.contains(where: { tempId in userId == tempId }) {
                photosInRealm = photosInRealm.filter { $0.userId == userId }
                let photosMap = photosInRealm.compactMap(\.photos.last)
                photos = photosMap.map(\.url)
                updatePhoto(view: contentView, photoNames: photos)
            } else {
                fetchPhotos(userId: userId)
            }
        } catch {
            print(error)
        }
    }
}
