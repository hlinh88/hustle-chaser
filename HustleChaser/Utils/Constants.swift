//
//  Constants.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 20/10/2023.
//

import UIKit

final class Constants {
    static var cornerRadius = 10
    static var savingsCellHeight = 125

    static var emptyString = ""

    static func randomColor() -> UIColor {
        let randomInt = Int.random(in: 0..<6)
        switch randomInt {
        case 0:
            return UIColor(named: "customBlue") ?? UIColor()
        case 1:
            return UIColor(named: "customGreen") ?? UIColor()
        case 2:
            return UIColor(named: "customLavender") ?? UIColor()
        case 3:
            return UIColor(named: "customPink") ?? UIColor()
        case 4:
            return UIColor(named: "customRed") ?? UIColor()
        default:
            return UIColor(named: "customYellow") ?? UIColor()
        }
    }
}
