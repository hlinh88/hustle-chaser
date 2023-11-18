//
//  NewSaving.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 18/11/2023.
//

import Foundation

struct NewSaving: Codable {
    var name: String
    var current: Int
    var target: Int
    var days: Int


    enum CodingKeys: String, CodingKey {
        case name
        case current
        case target
        case days
    }
}
