// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Синглтон для хранения данных о текущей сессии
final class Session {
    // MARK: - Public properties

    var userId = ""
    var token = ""
    static let shared = Session()

    // MARK: - Init

    private init() {}
}
