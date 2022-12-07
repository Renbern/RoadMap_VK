// NewsFeedResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Запросы 
struct NewsFeedResponse: Decodable {
    /// Новости
    let news: [NewsFeed]
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
