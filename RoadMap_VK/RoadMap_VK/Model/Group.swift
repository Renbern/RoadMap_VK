// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Хранение данных о группе
final class ItemGroup: Object, Codable {
    // MARK: - Constants
    private enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupPhotoImageName = "photo_100"
    }
    
    // MARK: - Public properties
    @Persisted(primaryKey: true) var groupName: String = ""
    @Persisted var groupPhotoImageName: String? = ""
}
