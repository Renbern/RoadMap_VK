// PhotoCacheService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

///  Расширешие для хранения ссылок на таблицу/коллекцию и обновление ее элементов
extension PhotoCacheService {
    class TableViewController: DataReloadable {
        // MARK: - Public properties

        let table: UITableViewController

        // MARK: - Initializers

        init(table: UITableViewController) {
            self.table = table
        }

        // MARK: - Public methods

        func reloadRow(at indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    class Table: DataReloadable {
        // MARK: - Public properties

        let table: UITableView

        // MARK: - Initializers

        init(table: UITableView) {
            self.table = table
        }

        // MARK: - Public methods

        func reloadRow(at indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
}
