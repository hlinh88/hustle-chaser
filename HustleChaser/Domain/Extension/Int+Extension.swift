//
//  Int+Extension.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import Foundation

extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
