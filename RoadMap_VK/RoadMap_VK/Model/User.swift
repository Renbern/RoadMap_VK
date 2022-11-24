// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ответ
struct FriendResponse: Codable {
    let response: Friends
}

/// Список друзей
struct Friends: Codable {
    let friendsCount: Int
    let friends: [FriendsItem]

    private enum CodingKeys: String, CodingKey {
        case friendsCount = "count"
        case friends = "items"
    }
}

/// Информация о друге
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
