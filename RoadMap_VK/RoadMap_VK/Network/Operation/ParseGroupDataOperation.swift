// ParseGroupDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Парсинг данных
final class ParseGroupDataOperation: Operation {
    // MARK: - Private properties

    var outputData: [ItemGroup] = []

    // MARK: - Public methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let decoder = JSONDecoder()
            let responses = try decoder.decode(VKResponse<ItemGroup>.self, from: data)
            let newItem = responses
            outputData = newItem.items
            print(newItem)
        } catch {
            print(error)
        }
    }
}
