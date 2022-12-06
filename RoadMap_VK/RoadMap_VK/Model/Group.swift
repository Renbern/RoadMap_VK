// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Информация о группе
final class ItemGroup: Object, Codable {
    // MARK: - Constants

    private enum CodingKeys: String, CodingKey {
        case id
        case groupName = "name"
        case groupPhotoImageName = "photo_100"
    }

    // MARK: - Public properties

    @Persisted(primaryKey: true) var groupName: String
    @Persisted var groupPhotoImageName: String?
    @Persisted var id: Int
}
