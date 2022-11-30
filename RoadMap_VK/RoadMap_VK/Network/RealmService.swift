// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

final class RealmService {
    func saveInRealm<T: Object>(_ data: [T]) {
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
