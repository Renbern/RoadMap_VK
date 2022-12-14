// Post.swift
// Copyright © RoadMap. All rights reserved.

/// Публикации
final class Post: Decodable {
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
    var likes: Likes?
    /// Просмотры
    var views: Views?
    /// Дата публикации
    var date: Double
    /// Вложения
    var attachments: [Attachment]?
    /// Тип публикации
    var type: PostType?

    enum CodingKeys: String, CodingKey {
        case id
        case sourceId = "source_id"
        case text
        case likes
        case views
        case date
        case attachments
    }

    enum PostType {
        case text
        case image
    }
}
