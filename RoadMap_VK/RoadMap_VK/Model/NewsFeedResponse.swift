// NewsFeedResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Запросы 
struct NewsFeedResponse: Decodable {
    let news: [NewsFeed]
    let groups: [ItemGroup]
    let friends: [FriendsItem]

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}
