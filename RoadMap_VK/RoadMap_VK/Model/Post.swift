// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип  поста
enum PostItemType {
    case text
    case image
}

/// Модель поста
struct PostItem {
    var author: String
    var postDate: String
    var text: String?
    var photo: String?
    var type: PostItemType
    static let fake: [PostItem] = (1 ... 10).map { _ in
        PostItem(
            author: "Nicholas Cage",
            postDate: "05.11.2020",
            text: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing",
            photo: String(Int.random(in: 1 ... 5)),
            type: Bool.random() ? .text : .image
        )
    }
}
