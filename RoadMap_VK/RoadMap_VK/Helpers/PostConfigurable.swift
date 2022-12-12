// PostConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Конфигурация ячейки
typealias PostCell = UITableViewCell & PostConfigurable

protocol PostConfigurable {
    func configure(post: Post, photoCacheService: PhotoCacheService)
}
