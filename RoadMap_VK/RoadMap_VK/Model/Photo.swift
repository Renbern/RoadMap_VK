// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Url фотографии
final class Url: Object, Decodable {
    // MARK: - Public properties
    @Persisted var url: String
}
