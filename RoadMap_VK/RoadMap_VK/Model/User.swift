// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Хранение данных о пользователе
final class FriendsItem: Object, Codable {
    // MARK: - Constants

    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case friendPhotoImageName = "photo_100"
    }

    // MARK: - Public properties

    @Persisted(primaryKey: true) var userId = 0
    @Persisted var firstName = ""
    @Persisted var lastName = ""
    @Persisted var friendPhotoImageName = ""
}
