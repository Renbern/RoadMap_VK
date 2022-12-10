// PhotoCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Cервис кэширования изображений
class PhotoCacheService {
    // MARK: - Constants

    private enum Constants {
        static let days = 30.0
        static let hours = 24.0
        static let minutes = 60.0
        static let seconds = 60.0
        static let cacheLifeTime = days * hours * minutes * seconds
        static let pathName = "Images"
        static let urlSeparator: Character = "/"
        static let defaultFileName: Substring = "default"
    }

    // MARK: - Private properties

    private static let pathName: String = { let pathName = Constants.pathName
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first else {
            return pathName
        }
        let url = cachesDirectory.appendingPathComponent(
            pathName,
            isDirectory: true
        )
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime
    private let container: DataReloadable
    private var images = [String: UIImage]()

    // MARK: - Initializers

    init(container: UITableViewController) {
        self.container = TableViewController(table: container)
    }

    init(container: UITableView) {
        self.container = Table(table: container)
    }

    // MARK: - Private methods

    func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first else {
            return nil
        }
        let hashName = url.split(separator: Constants.urlSeparator).last ?? Constants.defaultFileName
        return cachesDirectory.appendingPathComponent(
            PhotoCacheService.pathName + String(Constants.urlSeparator) + hashName
        ).path
    }

    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else {
            return nil
        }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName)
        else {
            return nil
        }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard let data = response.data,
                  let self = self,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self.images[url] = image
            }
            self.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self.container.reloadRow(at: indexPath)
            }
        }
    }

    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
}
