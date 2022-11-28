// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Хранение данных о группе
final class ItemGroup: Codable {
    @objc dynamic var groupName: String
    @objc dynamic var groupPhotoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupPhotoImageName = "photo_100"
    }
}
