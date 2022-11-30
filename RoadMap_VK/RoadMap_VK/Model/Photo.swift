// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Url фотографии
final class Url: Object, Decodable {
    @Persisted var url: String
}
