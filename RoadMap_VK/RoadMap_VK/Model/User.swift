// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Хранение данных о пользователе
final class FriendsItem: Object, Codable {
    @objc dynamic var userId: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var friendPhotoImageName: String?

    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case friendPhotoImageName = "photo_100"
    }
}
