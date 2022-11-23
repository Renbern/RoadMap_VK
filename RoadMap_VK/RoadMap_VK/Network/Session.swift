// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Синглтон для хранения данных о текущей сессии
final class Session {
    // MARK: - Public properties

    static let shared = Session()
    var userId = ""
    var token = ""

    // MARK: - Init

    private init() {}
}
