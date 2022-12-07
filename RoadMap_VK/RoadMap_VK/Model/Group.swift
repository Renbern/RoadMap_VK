// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Информация о группе
final class ItemGroup: Object, Codable {
    // MARK: - Constants

    private enum CodingKeys: String, CodingKey {
        /// Идентификатор группы
        case id
        /// Название группы
        case groupName = "name"
        /// Аватар группы
        case groupPhotoImageName = "photo_100"
    }

    // MARK: - Public properties

    @Persisted(primaryKey: true) var groupName: String
    @Persisted var groupPhotoImageName: String?
    @Persisted var id: Int
}
