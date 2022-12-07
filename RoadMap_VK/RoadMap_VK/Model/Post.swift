// Post.swift
// Copyright © RoadMap. All rights reserved.

/// Публикации
final class NewsFeed: Decodable {
    /// Идентификатор
    var id: Int
    /// Идентификатор публикации
    var sourceId: Int
    /// Текст публикации
    var text: String
    /// Автор публикации
    var authorName: String?
    /// Аватар автора публикации
    var avatarPath: String?
    /// Лайки
    var likes: Likes
    /// Просмотры
    var views: Views
    /// Дата публикации
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
