// VKResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель получения данных для парсинга
struct VKResponse<T: Decodable>: Decodable {
    var items: [T]
    enum CodingKeys: String, CodingKey {
        case response
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(
            keyedBy: CodingKeys.self,
            forKey: .response
        )
        items = try responseContainer.decode([T].self, forKey: .items)
    }
}
