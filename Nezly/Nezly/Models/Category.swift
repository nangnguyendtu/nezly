//
//  Categories.swift
//  Nezly
//
//  Created by Nguyen on 10/15/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import Foundation

struct Category : Codable, Equatable {
    var id: Int
    var title: String
    var description: String?
    var categories: [Category]?
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id 
    }
}
