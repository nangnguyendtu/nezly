//
//  Post.swift
//  Nezly
//
//  Created by Nguyen on 11/20/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import Foundation

struct Post : Codable, Equatable {
    var id: Int
    var title: String
    var description: String?
    var is_auction: Bool
    var is_buynow: Bool
    var image_id: Int
    var price: Float
    var quantity: Int
    var image: Images
}
