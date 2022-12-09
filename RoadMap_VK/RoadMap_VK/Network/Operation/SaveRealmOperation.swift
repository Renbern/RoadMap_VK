// SaveRealmOperation.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

final class SaveRealmOperation: Operation {
    // MARK: - Public methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseGroupDataOperation else { return }
        let parseData = getParseData.outputData
        do {
            let realm = try Realm()
            let oldData = realm.objects(ItemGroup.self)
            try realm.write {
                realm.delete(oldData)
                realm.add(parseData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
