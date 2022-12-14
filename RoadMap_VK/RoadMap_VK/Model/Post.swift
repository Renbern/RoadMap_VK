// Post.swift
// Copyright © RoadMap. All rights reserved.

/// Публикации
final class Post: Decodable {
    /// Идентификатор
    let id: Int
    /// Идентификатор публикации
    let sourceId: Int
    /// Текст публикации
    let text: String
    /// Дата публикации
    let date: Double
    /// Вложения
    let attachments: [Attachment]?
    /// Автор публикации
    var authorName: String?
    /// Аватар автора публикации
    var avatarPath: String?
    /// Лайки
    var likes: Likes?
    /// Просмотры
    var views: Views?
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
