// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Синглтон для хранения данных о текущей сессии
final class Session {
    static let shared = Session()
    private init() {}

    var userId = ""
    var token = ""
}
