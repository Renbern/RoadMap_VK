// VKResponse.swift
// Copyright © RoadMap. All rights reserved.

/// Модель получения данных для парсинга
struct VKResponse<T: Decodable>: Decodable {
    // MARK: - Constants

    enum CodingKeys: String, CodingKey {
        /// Ответ
        case response
        /// Объекты
        case items
    }

    // MARK: - Public property

    var items: [T]

    // MARK: - Init

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(
            keyedBy: CodingKeys.self,
            forKey: .response
        )
        items = try responseContainer.decode([T].self, forKey: .items)
    }
}
