// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Url фотографии
final class Url: Object, Decodable {
    @objc dynamic var url: String
}
