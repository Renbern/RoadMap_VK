// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Url фотографии
final class Url: Object, Decodable {
    // MARK: - Public properties

    var width: Int
    var height: Int
    var aspectRatio: CGFloat { CGFloat(height) / CGFloat(width) }

    @Persisted var url: String
}
