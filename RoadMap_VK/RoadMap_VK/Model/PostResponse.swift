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
    /// Следующая страница
    let nextPage: String?

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
        case nextPage = "next_from"
    }
}
