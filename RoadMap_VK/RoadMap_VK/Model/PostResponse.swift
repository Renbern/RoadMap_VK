// PostResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Запросы
struct PostResponse: Decodable {
    /// Новости
    let news: [Post]
    /// Группы
    let groups: [ItemGroup]
    /// Друзья
    let friends: [FriendsItem]

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}
