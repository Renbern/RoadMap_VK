// Post.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Публикации
final class NewsFeed: Decodable {
    var id: Int
    var sourceId: Int
    var text: String
    var authorName: String?
    var avatarPath: String?
    var likes: Likes
    var views: Views
    var date: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case sourceId = "source_id"
        case text
        case likes
        case views
        case date
    }
}
