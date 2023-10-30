//
//  NewExpense.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 29/10/2023.
//

import Foundation

struct NewExpense: Codable {
    var source: String
    var amount: Int
    var type: Bool
    var color: Int

    enum CodingKeys: String, CodingKey {
        case source
        case amount
        case type
        case color
    }
}
