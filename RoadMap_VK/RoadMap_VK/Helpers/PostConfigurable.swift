// PostConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias PostCell = UITableViewCell & PostConfigurable

protocol PostConfigurable {
    func configure(item: PostItem)
}
