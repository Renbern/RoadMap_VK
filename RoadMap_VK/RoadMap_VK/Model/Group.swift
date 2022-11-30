// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Хранение данных о группе
final class ItemGroup: Object, Codable {
    @Persisted var groupName: String = ""
    @Persisted var groupPhotoImageName: String? = ""

    private enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupPhotoImageName = "photo_100"
    }

    override static func primaryKey() -> String? {
        "groupName"
    }
}
