//
//  User.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 6/11/2023.
//

import Foundation

struct User: Codable {
    var id: String
    var balance: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case balance
        case name
    }
}
