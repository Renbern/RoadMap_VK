// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ответ
struct Group: Codable {
    let response: GroupResponse
}

/// Список групп
struct GroupResponse: Codable {
    let groupsCount: Int
    let groups: [ItemGroup]

    private enum CodingKeys: String, CodingKey {
        case groupsCount = "count"
        case groups = "items"
    }
}

/// Группа
final class ItemGroup: Codable {
    @objc dynamic var groupName: String
    @objc dynamic var groupPhotoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case groupName = "name"
        case groupPhotoImageName = "photo_100"
    }
}
