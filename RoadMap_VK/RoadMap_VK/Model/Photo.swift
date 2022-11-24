// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ответ
struct UserPhoto: Codable {
    let response: Album
}

/// Пользователь
struct Album: Codable {
    let photosCount: Int
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photosCount = "count"
        case photos = "items"
    }
}

/// Фото
struct Photo: Codable {
    let ownerId: Int
    let photo: [Url]

    private enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case photo = "sizes"
    }
}

/// Url фотографии
final class Url: Object, Codable {
    @objc dynamic var url: String
}
