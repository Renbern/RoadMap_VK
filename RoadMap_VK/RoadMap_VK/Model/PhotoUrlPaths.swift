// PhotoUrlPaths.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Пути к фотографиям пользователя
final class PhotoUrlPaths: Object, Decodable {
    // MARK: - Constants

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "owner_id"
        case photos = "sizes"
    }

    // MARK: - Public properties

    @Persisted(primaryKey: true) var id: Int
    @Persisted var userId: Int
    @Persisted var photos = List<Url>()
}
