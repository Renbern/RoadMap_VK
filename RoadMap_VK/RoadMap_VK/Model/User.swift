// User.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Информация о пользователе
final class FriendsItem: Object, Codable {
    // MARK: - Constants

    private enum CodingKeys: String, CodingKey {
        /// Идентификатор пользователя
        case userId = "id"
        /// Имя
        case firstName = "first_name"
        /// Фамилия
        case lastName = "last_name"
        /// Фото
        case friendPhotoImageName = "photo_100"
    }

    // MARK: - Public properties

    @Persisted(primaryKey: true) var userId = 0
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var friendPhotoImageName: String
}
