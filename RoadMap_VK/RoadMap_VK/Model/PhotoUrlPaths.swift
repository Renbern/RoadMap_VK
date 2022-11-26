// PhotoUrlPaths.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Пути к фотографиям пользователя
struct PhotoUrlPaths: Decodable {
    let photos: [Url]

    enum CodingKeys: String, CodingKey {
        case photos = "sizes"
    }
}
